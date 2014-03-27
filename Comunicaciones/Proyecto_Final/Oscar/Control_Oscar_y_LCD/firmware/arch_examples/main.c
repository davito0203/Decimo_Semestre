int function(int x){
  return x;
}

int main(void)
{
  volatile unsigned char    *data8;
  volatile unsigned short   *data16;
  volatile unsigned int     *data32;

  unsigned int op1, op2, result1, result2, result3;
  unsigned char             loop;

/*
   Operaciones de acceso a memoria
*/

  data8  = (volatile unsigned char  *)(0x00004000);
  data16 = (volatile unsigned short *)(0x00002000);
  data32 = (volatile unsigned int   *)(0x00003000);

  *data8  = 0x44;
  data8++;
  *data8  = 0x66;
  data8++;
  *data8  = 0x55;
  data8++;
  *data8  = 0x22;
  data8++;
  *data8  = 0x11;
 
  *data16 = 0x2020;
  data16++;
  *data16 = 0x2121;
  data16++;
  *data16 = 0x2222;
  data16++;
 
  *data32 = 0x40403030;
  data32++;
  *data32 = 0x31313131;


  data32 ++;
  result1 = *data32;
  data32 ++;
  result2 = *data32;
  data32 ++;
  result3 = *data32;

/*
  Operaciones aritméticas
*/

  op1 = 0xAA;
  op2 = 0x55;

  result1 = op1 + op2;
  result2 = op1 - op2;
  result3 = op1 | op2;
  
  data32 ++;
  *data32 = result1;
  data32 ++;
  *data32 = result2;
  data32 ++;
  *data32 = result3;
/*
  saltos
*/

  for(loop = 0; loop == 10; loop++){
  }

  for(loop = 0; loop < 10; loop++){
  }

  for(loop = 0; loop > 10; loop++){
  }

  loop = 0;
  while(loop < 10){
    loop++;
  }


/*
  llamado a funciones
*/

  
  result1 = function(0x30);


/*
  Comunicación con periféricos
*/
      data32 = (volatile unsigned int   *)(0x40000000);
      data32++;
      data32++;
      *data32 = 0xFF;
      data32 = (volatile unsigned int   *)(0x40000000);
      data32++;
      *data32 = 0x55;

      data32 = (volatile unsigned int   *)(0x40000000);
      data32++;
      data32++;
      *data32 = 0xFF;
      data32 = (volatile unsigned int   *)(0x40000000);
      data32++;
      *data32 = 0xBB;


      data32 = (volatile unsigned int   *)(0x40000000);
      data32++;
      data32++;
      *data32 = 0x00;
      data32 = (volatile unsigned int   *)(0x40000000);
      data32++;
      *data32 = 0xBB;



      
  while(1){

  }
  return 0;


}





