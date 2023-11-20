package uz.udevs.payze

import android.content.Intent
import android.os.Bundle
import android.util.Log
import androidx.appcompat.app.AppCompatActivity
import com.payze.paylib.Payze
import com.payze.paylib.model.CardInfo

class PayzeActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_payze)
        val data = intent.extras
        data?.let {
            val payze = Payze(context = this)
            val cardNumber: String = it.getString("number").toString()
            val cardHolder: String = it.getString("cardHolder").toString()
            val cardExpiredDate: String = it.getString("expirationDate").toString()
            val cardSecurityNumber: String = it.getString("securityNumber").toString()
            val transactionId: String = it.getString("transactionId").toString()
            val cardInfo = CardInfo(
                number = cardNumber,
                cardHolder = cardHolder,
                expirationDate = cardExpiredDate,
                securityNumber = cardSecurityNumber,
            )
            Log.d("TAG", "onCreate: $cardInfo")

            payze.pay(
                cardInfo,
                transactionId,
                onSuccess = {
                    val intent = Intent()
                    intent.putExtra("result", "true")
                    setResult(PAYZE_ACTIVITY_FINISH, intent)
                    finish()
                },
                onError = { code, error ->
                    Log.d("Payze android", code.toString())
                    Log.d("Payze android", error.toString())
                    val intent = Intent()
                    intent.putExtra("result", "false")
                    setResult(PAYZE_ACTIVITY_FINISH, intent)
                    finish()
                },
            )
        }
    }

    override fun onBackPressed() {
        val intent = Intent()
        setResult(PAYZE_ACTIVITY_FINISH, intent)
        finish()
        super.onBackPressed()
    }

}