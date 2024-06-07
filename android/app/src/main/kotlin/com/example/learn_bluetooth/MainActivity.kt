package com.example.learn_bluetooth

// import io.flutter.embedding.android.FlutterActivity
import android.bluetooth.BluetoothAdapter
import android.bluetooth.BluetoothDevice
import android.bluetooth.BluetoothProfile
import android.content.Context
import android.media.AudioManager
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
      private val CHANNEL = "com.example.learnBluetooth"

        override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "connectToAudioDevice") {
                print("debugConnectAudioDevice")
                connectToAudioDevice()
                result.success(null)
            } else {
                result.notImplemented()
            }
        }
    }

      private fun connectToAudioDevice() {
        val bluetoothAdapter: BluetoothAdapter? = BluetoothAdapter.getDefaultAdapter()
        val audioManager: AudioManager = getSystemService(Context.AUDIO_SERVICE) as AudioManager

        bluetoothAdapter?.getProfileProxy(applicationContext, object : BluetoothProfile.ServiceListener {
            override fun onServiceConnected(profile: Int, proxy: BluetoothProfile) {
                if (profile == BluetoothProfile.A2DP) {
                    val a2dp = proxy as BluetoothProfile
                    val devices = a2dp.connectedDevices
                    if (devices.isNotEmpty()) {
                        audioManager.isBluetoothA2dpOn = true
                        audioManager.startBluetoothSco()
                        audioManager.mode = AudioManager.MODE_IN_CALL
                    }
                }
            }

            override fun onServiceDisconnected(profile: Int) {
                // Handle disconnection
            }
        }, BluetoothProfile.A2DP)
    }
}
