package com.example.finwell

import android.database.sqlite.SQLiteDatabase
import android.os.Build
import android.util.Log
import androidx.annotation.RequiresApi
import java.time.LocalDate
import java.time.format.DateTimeFormatter

class DatabaseHelper {



    val LocalDate.day: Int
        @RequiresApi(Build.VERSION_CODES.O)
        get() = this.dayOfMonth

    val LocalDate.monthName: String
        @RequiresApi(Build.VERSION_CODES.O)
        get() = this.format(DateTimeFormatter.ofPattern("MMMM"))

    val LocalDate.year: String
        @RequiresApi(Build.VERSION_CODES.O)
        get() = this.year.toString()
    companion object{
        var instance:DatabaseHelper = DatabaseHelper()
    }
    var db: SQLiteDatabase? = null
    var dbPath = "/data/user/0/com.example.finwell/app_flutter/finwell.db"

    val tableName = "transactions"
    val columnAmount = "TransactionAmount"
    val columnCategory = "TransactionCategory"
    val columnDate = "TransactionDate"
    val columnTransactionId = "TransactionId"
    val columnTransactionName = "TransactionName"
    val columnTransactionType = "TransactionType"
    val columnTransactionStatus = "TransactionStatus"
    var columnTransactionMonth = "TransactionMonth"
    var columnTrasactionYear = "TransactionYear"



    private fun openDataBase(){

        if (db == null){
            db = SQLiteDatabase.openDatabase(dbPath,null,SQLiteDatabase.OPEN_READWRITE)
            Log.e("db","$db")
        }
    }

    @RequiresApi(Build.VERSION_CODES.O)
    fun insertTransaction(amount:String, isDebited:Boolean){
        openDataBase()
        val defaultCategory = "Housing"
        val defaultTransactionName = "Jon Doe Transaction"
        val millisecondsSinceEpoch: Long = System.currentTimeMillis()
        val transactionId = millisecondsSinceEpoch.toString()
        var isExpense = "expense";
        val status = 0
        val today = LocalDate.now()

        isExpense = if(isDebited){
            "expense"
        }
        else{
            "income"
        }
try {
    val sql = "INSERT into $tableName ($columnAmount,$columnCategory,$columnDate, $columnTransactionId, $columnTransactionName, $columnTransactionType, $columnTransactionStatus,$columnTransactionMonth,$columnTrasactionYear) VALUES(\"$amount\", \"$defaultCategory\", \"$millisecondsSinceEpoch\",\"$transactionId\",\"$defaultTransactionName\",\"$isExpense\",\"$status\",\"${today.monthName.lowercase()}\",\"${today.year}\\)"
    db!!.execSQL(sql)
}
catch (e:Exception){
    Log.e("insert Exception",e.toString())
}

    }




}