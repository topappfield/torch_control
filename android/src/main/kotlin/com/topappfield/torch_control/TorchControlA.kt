@file:Suppress("DEPRECATION")
package com.topappfield.torch_control

import android.content.Context
import android.content.pm.PackageManager
import android.hardware.Camera

class TorchControlA(private val context: Context) : TorchControl() {
    private var camera: Camera? = null

    override fun acquire(): Boolean {
        if (camera != null) release()
        // system check
        if (!context.packageManager.hasSystemFeature(PackageManager.FEATURE_CAMERA_FLASH))
            return false
        // open camera
        camera = try {
            Camera.open()
        } catch (e: Exception) {
            null
        }
        if (camera == null) return false
        // check parameters
        var result = (camera!!.parameters.flashMode != null)
        // check flash modes
        val modes = camera!!.parameters.supportedFlashModes
        result = result && modes != null && modes.isNotEmpty()
        result = result && !modes[0].equals(Camera.Parameters.FLASH_MODE_OFF)
        // return
        if (!result) release()
        return result;
        return true
    }

    override fun release() {
        camera?.release()
        camera = null
    }

    override fun ready(): Boolean {
        if (camera != null) return true
        return acquire()
    }

    override fun turn(state: Boolean): Boolean {
        camera!!.parameters.flashMode = if (state) Camera.Parameters.FLASH_MODE_TORCH else Camera.Parameters.FLASH_MODE_OFF
        if (state) camera!!.startPreview() else camera!!.stopPreview()
        return state
    }
}
