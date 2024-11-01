package com.example.finwell

import android.database.sqlite.SQLiteDatabase
import android.util.Log

class DatabaseHelper {

    companion object{
        var instance:DatabaseHelper = DatabaseHelper()
    }
    var db: SQLiteDatabase? = null
    var dbPath = "/data/user/0/com.example.finwell/app_flutter/finwell.db"

    val tableName = "transactions"
    val columnAmount = "TransactionAmount"
    val columnCategory = "TransactionCategory"
    val columnDate = "TransactionDate" // Corrected spelling from "TranscationDate"
    val columnTransactionId = "TransactionId"
    val columnTransactionName = "TransactionName"
    val columnTransactionType = "TransactionType"
    val columnTransactionStatus = "TransactionStatus"



    private fun openDataBase(){

        if (db == null){
            db = SQLiteDatabase.openDatabase(dbPath,null,SQLiteDatabase.OPEN_READWRITE)
            Log.e("db","$db")
        }
    }

    fun insertTransaction(amount:String,isDebited:Boolean){
        openDataBase()
        val defaultCategory = "Housing"
        val defaultTransactionName = "Jon Doe Transaction"
        val millisecondsSinceEpoch: Long = System.currentTimeMillis()
        val transactionId = millisecondsSinceEpoch.toString()
        var isExpense = "expense";
        val status = 0

        isExpense = if(isDebited){
            "expense"
        }
        else{
            "income"
        }
try {
    val sql = "INSERT into $tableName ($columnAmount,$columnCategory,$columnDate, $columnTransactionId, $columnTransactionName, $columnTransactionType, $columnTransactionStatus) VALUES(\"$amount\", \"$defaultCategory\", \"$millisecondsSinceEpoch\",\"$transactionId\",\"$defaultTransactionName\",\"$isExpense\",\"$status\")"
    db!!.execSQL(sql)
}
catch (e:Exception){
    Log.e("insert Exception",e.toString())
}

    }




}