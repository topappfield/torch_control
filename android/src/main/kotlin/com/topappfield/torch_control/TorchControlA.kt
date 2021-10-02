@file:Suppress("DEPRECATION")
package com.topappfield.torch_control

import android.content.Context
import android.content.pm.PackageManager
import android.hardware.Camera

class TorchControlA(private val context: Context) : TorchControl() {
    private var camera: Camera? = null

    private fun checkCamera(): Camera? {
        if (camera != null) return camera
        camera = try {
            Camera.open()
        } catch (e: Exception) {
            null
        }
        return camera;
    }

    override fun release() {
        camera?.release()
        camera = null
    }

    override fun hasTorch(): Boolean {
        return context.packageManager.hasSystemFeature(PackageManager.FEATURE_CAMERA_FLASH)
    }

    override fun turn(state: Boolean): Boolean {
        val camera = checkCamera() ?: return false
        camera.parameters.flashMode = if (state) Camera.Parameters.FLASH_MODE_TORCH else Camera.Parameters.FLASH_MODE_OFF
        if (state) camera.startPreview() else camera.stopPreview()
        return state
    }
}
