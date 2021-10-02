package com.topappfield.torch_control

import android.content.Context
import android.hardware.camera2.CameraCharacteristics
import android.hardware.camera2.CameraManager
import android.os.Build
import androidx.annotation.RequiresApi

@RequiresApi(Build.VERSION_CODES.M)
class TorchControlB(context: Context) : TorchControl() {
    private val cameraManager = context.getSystemService(Context.CAMERA_SERVICE) as CameraManager
    private val cameraId = cameraManager.cameraIdList.first {
        id -> cameraManager.getCameraCharacteristics(id)[CameraCharacteristics.FLASH_INFO_AVAILABLE] != null
    } ?: null

    override fun release() {}

    override fun hasTorch(): Boolean = cameraId != null

    override fun turn(state: Boolean): Boolean {
        if (cameraId == null) return false
        cameraManager.setTorchMode(cameraId, state)
        return state
    }
}
