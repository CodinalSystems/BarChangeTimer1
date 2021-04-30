//+------------------------------------------------------------------+
//|                                               BarChangeTimer.mq4 |
//|                                                  Codinal Systems |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Codinal Systems"
#property link      "https://codinal-systems.com/"
#property version   "1.00"
#property strict

enum TimerPos{
   LEFT_UPPER, //左上
   RIGHT_UPPER, //右上
   LEFT_LOWER,//左下
   RIGHT_LOWER //左上
};

int input timerSize = 24; //フォントサイズ
color input timerColor = clrWhite; //フォントカラー
input TimerPos timerPos = RIGHT_UPPER; //角の位置
input int PosX = 0; //X座標の位置(px単位)
input int PosY = 0; //Y座標の位置(px単位)

void OnInit(){

   ObjectCreate("TimerObj", OBJ_LABEL, 0, 0, 0);
   
   switch(timerPos){
   
      case LEFT_UPPER:
         ObjectSetInteger(0,"TimerObj", OBJPROP_CORNER, CORNER_LEFT_UPPER);
         ObjectSetInteger(0,"TimerObj", OBJPROP_ANCHOR, ANCHOR_LEFT_UPPER);
         break;
         
      case RIGHT_UPPER:
         ObjectSetInteger(0,"TimerObj", OBJPROP_CORNER, CORNER_RIGHT_UPPER);
         ObjectSetInteger(0,"TimerObj", OBJPROP_ANCHOR, ANCHOR_RIGHT_UPPER);
         break;
         
      case LEFT_LOWER:
         ObjectSetInteger(0,"TimerObj", OBJPROP_CORNER, CORNER_LEFT_LOWER);
         ObjectSetInteger(0,"TimerObj", OBJPROP_ANCHOR, ANCHOR_LEFT_LOWER);
         break;
         
      case RIGHT_LOWER:
         ObjectSetInteger(0,"TimerObj", OBJPROP_CORNER, CORNER_RIGHT_LOWER);
         ObjectSetInteger(0,"TimerObj", OBJPROP_ANCHOR, ANCHOR_RIGHT_LOWER);
         break;
   }
   
   ObjectSetInteger(0,"TimerObj", OBJPROP_XDISTANCE, PosX);
   ObjectSetInteger(0,"TimerObj", OBJPROP_YDISTANCE, PosY);
   ObjectSetText("TimerObj", "", timerSize, "Meiryo UI", timerColor); 
   EventSetTimer(1);
}

void deinit(){

   ObjectDelete("TimerObj");
}

void OnTimer(){
   
   int secRemaining = Time[0] + Period() * 60 - TimeCurrent();
   int hour = secRemaining / 3600;
   int min = (secRemaining / 60) % 60;
   int sec = secRemaining - min * 60 - hour * 3600;
   
   string minStr = AddZero(min);
   string secStr = AddZero(sec);
   string TimeText;
   
   if(Period() <= 60){
     TimeText = minStr + ":" + secStr;
   }else{
     TimeText = hour +":"+ minStr + ":" + secStr;
   }
	ObjectSetText("TimerObj", TimeText);
	
	if (hour == 0 && min == 0 && sec < 10){
	   ObjectSet("TimerObj", OBJPROP_COLOR, clrRed);
	}
	
}

void start(){
}

//1秒を01秒にするための関数
string AddZero(int time){

   if (time > 0 && time < 10){
      return "0" + (string)time;
   }else if (time <= 0){
      return "00"; //ラグでマイナス秒になるのを防ぐ
   }else{
      return (string)time;
   }
}