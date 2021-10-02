package com.topappfield.torch_control

abstract class TorchControl {
    abstract fun release()
    abstract fun hasTorch(): Boolean
    abstract fun turn(state: Boolean): Boolean
}
