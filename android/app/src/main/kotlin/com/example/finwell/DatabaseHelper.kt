package com.example.finwell

import android.database.sqlite.SQLiteDatabase
import android.util.Log

class DatabaseHelper {

    companion object{
        var instance:DatabaseHelper = DatabaseHelper()
    }
    var db: SQLiteDatabase? = null
    var dbPath = "/data/user/0/com.example.finwell/app_flutter/finwell.db"


    private fun openDataBase(){

        if (db == null){
            db = SQLiteDatabase.openDatabase(dbPath,null,SQLiteDatabase.OPEN_READWRITE)
            Log.e("db","$db")
        }
    }

    fun insertMessage(message:String){
        openDataBase()
        val sql = "INSERT into messages (message) VALUES(${message})"
        db!!.execSQL(sql)

    }




}