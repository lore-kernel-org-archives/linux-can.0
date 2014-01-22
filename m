From: Gediminas Simanskis <gediminas@8devices.com>
Subject: Re: usb_8dev: firmware and windows library
Date: Wed, 22 Jan 2014 07:42:31 +0200
Message-ID: <52DF5A47.6060007@8devices.com>
References: <f5902be125a3dd5ead00d75e01a45fa5.squirrel@webmail.universalnet.at>	<52DE5EEF.6080100@hartkopp.net>	<52DE60C7.3050906@8devices.com>	<21214.26072.886368.818659@gargle.gargle.HOWL>	<52DE9A66.5070703@8devices.com> <21214.39717.229497.687562@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040902020107030903070708"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ea0-f169.google.com ([209.85.215.169]:35974 "EHLO
	mail-ea0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741AbaAVFme (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 22 Jan 2014 00:42:34 -0500
Received: by mail-ea0-f169.google.com with SMTP id l9so3705292eaj.0
        for <linux-can@vger.kernel.org>; Tue, 21 Jan 2014 21:42:33 -0800 (PST)
In-Reply-To: <21214.39717.229497.687562@gargle.gargle.HOWL>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: bon@elektron.ikp.physik.tu-darmstadt.de
Cc: linux-can@vger.kernel.org

This is a multi-part message in MIME format.
--------------040902020107030903070708
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,
attached

>>>>>> "Gediminas" == Gediminas Simanskis <gediminas@8devices.com> writes:
>      Gediminas> Hi, this image was compiled using commercial version IAR
>      Gediminas> compiller for ARM.
>
> I understand.
>
> But isn't there any output log during the build stage that tells what files
> are compiled with what options and defines?
>
> Thanks


--------------040902020107030903070708
Content-Type: text/plain; charset=windows-1257;
 name="usb2can.map"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="usb2can.map"

###############################################################################
#                                                                             #
# IAR ELF Linker V5.41.0.51741/W32 for ARM              18/Dec/2013  12:41:15 #
# Copyright (C) 2007-2009 IAR Systems AB.                                     #
#                                                                             #
#    Output file  =  C:\Users\Ged\Documents\Work\USB2CAN\Firmware\IAR\Debug\E #
#                    xe\usb2can.out.tmp                                       #
#    Map file     =  C:\Users\Ged\Documents\Work\USB2CAN\Firmware\IAR\Debug\L #
#                    ist\usb2can.map                                          #
#    Command line =  C:\Users\Ged\Documents\Work\USB2CAN\Firmware\IAR\Debug\O #
#                    bj\75x_can.o C:\Users\Ged\Documents\Work\USB2CAN\Firmwar #
#                    e\IAR\Debug\Obj\75x_cfg.o C:\Users\Ged\Documents\Work\US #
#                    B2CAN\Firmware\IAR\Debug\Obj\75x_eic.o                   #
#                    C:\Users\Ged\Documents\Work\USB2CAN\Firmware\IAR\Debug\O #
#                    bj\75x_gpio.o C:\Users\Ged\Documents\Work\USB2CAN\Firmwa #
#                    re\IAR\Debug\Obj\75x_i2c.o C:\Users\Ged\Documents\Work\U #
#                    SB2CAN\Firmware\IAR\Debug\Obj\75x_init.o                 #
#                    C:\Users\Ged\Documents\Work\USB2CAN\Firmware\IAR\Debug\O #
#                    bj\75x_it.o C:\Users\Ged\Documents\Work\USB2CAN\Firmware #
#                    \IAR\Debug\Obj\75x_lib.o C:\Users\Ged\Documents\Work\USB #
#                    2CAN\Firmware\IAR\Debug\Obj\75x_mrcc.o                   #
#                    C:\Users\Ged\Documents\Work\USB2CAN\Firmware\IAR\Debug\O #
#                    bj\75x_pwm.o C:\Users\Ged\Documents\Work\USB2CAN\Firmwar #
#                    e\IAR\Debug\Obj\75x_tb.o C:\Users\Ged\Documents\Work\USB #
#                    2CAN\Firmware\IAR\Debug\Obj\75x_tim.o                    #
#                    C:\Users\Ged\Documents\Work\USB2CAN\Firmware\IAR\Debug\O #
#                    bj\75x_uart.o C:\Users\Ged\Documents\Work\USB2CAN\Firmwa #
#                    re\IAR\Debug\Obj\75x_vect.o                              #
#                    C:\Users\Ged\Documents\Work\USB2CAN\Firmware\IAR\Debug\O #
#                    bj\75x_wdg.o C:\Users\Ged\Documents\Work\USB2CAN\Firmwar #
#                    e\IAR\Debug\Obj\Checksum.o C:\Users\Ged\Documents\Work\U #
#                    SB2CAN\Firmware\IAR\Debug\Obj\buffers.o                  #
#                    C:\Users\Ged\Documents\Work\USB2CAN\Firmware\IAR\Debug\O #
#                    bj\commands.o C:\Users\Ged\Documents\Work\USB2CAN\Firmwa #
#                    re\IAR\Debug\Obj\configuration.o                         #
#                    C:\Users\Ged\Documents\Work\USB2CAN\Firmware\IAR\Debug\O #
#                    bj\hw_config.o C:\Users\Ged\Documents\Work\USB2CAN\Firmw #
#                    are\IAR\Debug\Obj\i2c_ee.o C:\Users\Ged\Documents\Work\U #
#                    SB2CAN\Firmware\IAR\Debug\Obj\leds.o                     #
#                    C:\Users\Ged\Documents\Work\USB2CAN\Firmware\IAR\Debug\O #
#                    bj\lists.o C:\Users\Ged\Documents\Work\USB2CAN\Firmware\ #
#                    IAR\Debug\Obj\low_level_init.o                           #
#                    C:\Users\Ged\Documents\Work\USB2CAN\Firmware\IAR\Debug\O #
#                    bj\main.o C:\Users\Ged\Documents\Work\USB2CAN\Firmware\I #
#                    AR\Debug\Obj\messages.o C:\Users\Ged\Documents\Work\USB2 #
#                    CAN\Firmware\IAR\Debug\Obj\usb_core.o                    #
#                    C:\Users\Ged\Documents\Work\USB2CAN\Firmware\IAR\Debug\O #
#                    bj\usb_desc.o C:\Users\Ged\Documents\Work\USB2CAN\Firmwa #
#                    re\IAR\Debug\Obj\usb_endp.o                              #
#                    C:\Users\Ged\Documents\Work\USB2CAN\Firmware\IAR\Debug\O #
#                    bj\usb_init.o C:\Users\Ged\Documents\Work\USB2CAN\Firmwa #
#                    re\IAR\Debug\Obj\usb_int.o C:\Users\Ged\Documents\Work\U #
#                    SB2CAN\Firmware\IAR\Debug\Obj\usb_istr.o                 #
#                    C:\Users\Ged\Documents\Work\USB2CAN\Firmware\IAR\Debug\O #
#                    bj\usb_mem.o C:\Users\Ged\Documents\Work\USB2CAN\Firmwar #
#                    e\IAR\Debug\Obj\usb_prop.o C:\Users\Ged\Documents\Work\U #
#                    SB2CAN\Firmware\IAR\Debug\Obj\usb_pwr.o                  #
#                    C:\Users\Ged\Documents\Work\USB2CAN\Firmware\IAR\Debug\O #
#                    bj\usb_regs.o --redirect _Printf=_PrintfSmall            #
#                    --redirect _Scanf=_ScanfSmall -o                         #
#                    C:\Users\Ged\Documents\Work\USB2CAN\Firmware\IAR\Debug\E #
#                    xe\usb2can.out.tmp --map C:\Users\Ged\Documents\Work\USB #
#                    2CAN\Firmware\IAR\Debug\List\usb2can.map --config        #
#                    C:\Users\Ged\Documents\Work\USB2CAN\Firmware\IAR\linker\ #
#                    STR75x_FLASH.icf --semihosting --entry                   #
#                    __iar_program_start --place_holder                       #
#                    __checksum,2,.checksum,1 --define_symbol                 #
#                    __checksum_begin=0x20006000 --define_symbol              #
#                    __checksum_end=0x2000bffb                                #
#                                                                             #
#                                                                             #
###############################################################################

*******************************************************************************
*** PLACEMENT SUMMARY
***

"P1":  place in [from 0x20006000 to 0x2000bfff] { block IntVecInit };
"P2":  place in [from 0x40000000 to 0x40003fff] { block IntVec };
"P3":  place in [from 0x20006000 to 0x2000bfff] { ro };
"P4":  place in [from 0x40000000 to 0x40003fff] {
          rw, block CSTACK, block SVC_STACK, block IRQ_STACK, block FIQ_STACK,
          block UND_STACK, block ABT_STACK, block HEAP };
"A1":  place at 0x200c0000 { section configuration };
"A2":  place at end of [0x20006000-0x2000bfff] { ro section .checksum };

  Section              Kind        Address    Size  Object
  -------              ----        -------    ----  ------
"P1":                                        0x6f0
  IntVecInit                    0x20006000   0x6f0  <Block>
    Initializer bytes  ro data  0x20006000   0x6f0  <for IntVec-1>
                              - 0x200066f0   0x6f0

"P3":                                       0x4508
  .text                ro code  0x200066f0   0xd2c  usb_core.o [1]
  .text                ro code  0x2000741c   0x634  75x_can.o [1]
  .text                ro code  0x20007a50   0x630  75x_mrcc.o [1]
  .text                ro code  0x20008080   0x4f0  messages.o [1]
  .text                ro code  0x20008570   0x3a8  hw_config.o [1]
  .text                ro code  0x20008918   0x3a8  main.o [1]
  .text                ro code  0x20008cc0   0x370  usb_prop.o [1]
  .text                ro code  0x20009030   0x2f4  leds.o [1]
  .text                ro code  0x20009324   0x2f4  usb_regs.o [1]
  .text                ro code  0x20009618   0x29c  usb_int.o [1]
  .text                ro code  0x200098b4   0x238  commands.o [1]
  .text                ro code  0x20009aec   0x210  75x_gpio.o [1]
  .rodata              const    0x20009cfc   0x200  Checksum.o [1]
  .text                ro code  0x20009efc   0x1c4  75x_it.o [1]
  .text                ro code  0x2000a0c0   0x180  75x_tb.o [1]
  .text                ro code  0x2000a240   0x154  lists.o [1]
  .text                ro code  0x2000a394   0x11c  75x_init.o [1]
  .text                ro code  0x2000a4b0    0xd4  ABImemcpy.o [4]
  .text                ro code  0x2000a584    0x98  75x_eic.o [1]
  .text                ro code  0x2000a61c    0x90  usb_istr.o [1]
  .text                ro code  0x2000a6ac    0x84  75x_wdg.o [1]
  .text                ro code  0x2000a730    0x64  usb_mem.o [1]
  .text                ro code  0x2000a794    0x4c  Checksum.o [1]
  .text                ro code  0x2000a7e0    0x48  usb_pwr.o [1]
  .text                ro code  0x2000a828    0x38  usb_endp.o [1]
  .text                ro code  0x2000a860    0x38  data_init2.o [4]
  .text                ro code  0x2000a898    0x34  usb_init.o [1]
  .text                ro code  0x2000a8cc    0x34  iarwstd.o [5]
  .rodata              const    0x2000a900    0x30  usb_desc.o [1]
  .text                ro code  0x2000a930    0x2c  copy_init2.o [4]
  .text                ro code  0x2000a95c    0x28  zero_init2.o [4]
  .rodata              const    0x2000a984    0x24  usb_desc.o [1]
  .text                ro code  0x2000a9a8    0x24  cmain.o [4]
  .iar.init_table      const    0x2000a9cc    0x38  - Linker created -
  .rodata              const    0x2000aa04    0x20  usb_desc.o [1]
  .text                ro code  0x2000aa24    0x20  75x_cfg.o [1]
  .text                ro code  0x2000aa44    0x20  uread4.o [4]
  .text                ro code  0x2000aa64    0x20  exit.o [5]
  .rodata              const    0x2000aa84    0x14  usb_desc.o [1]
  .text                ro code  0x2000aa98    0x10  cexit.o [4]
  .text                ro code  0x2000aaa8     0x8  low_level_init.o [1]
  .text                ro code  0x2000aab0     0x8  exit.o [3]
  .rodata              const    0x2000aab8     0x4  usb_desc.o [1]
  .text                ro code  0x2000aabc     0x4  xreturnswi.o [5]
  Initializer bytes    ro data  0x2000aac0   0x138  <for P4 s0>
                              - 0x2000abf8  0x4508

"A2":                                          0x2
  .checksum            const    0x2000bffe     0x2  Place holder __checksum
                              - 0x2000c000     0x2

"A1":                                          0xc
  configuration        uninit   0x200c0000     0xc  configuration.o [1]
                              - 0x200c000c     0xc

"P2":                                        0x6f0
  IntVec                        0x40000000   0x6f0  <Block>
    IntVec-1                    0x40000000   0x6f0  <Init block>
      .intvec          inited   0x40000000   0x6f0  75x_vect.o [1]
                              - 0x400006f0   0x6f0

"P4", part 1 of 3:                           0x700
  CSTACK                        0x400006f0   0x200  <Block>
    CSTACK             uninit   0x400006f0   0x200  <Block tail>
  SVC_STACK                     0x400008f0   0x100  <Block>
    SVC_STACK          uninit   0x400008f0   0x100  <Block tail>
  IRQ_STACK                     0x400009f0   0x100  <Block>
    IRQ_STACK          uninit   0x400009f0   0x100  <Block tail>
  FIQ_STACK                     0x40000af0   0x100  <Block>
    FIQ_STACK          uninit   0x40000af0   0x100  <Block tail>
  UND_STACK                     0x40000bf0   0x100  <Block>
    UND_STACK          uninit   0x40000bf0   0x100  <Block tail>
  ABT_STACK                     0x40000cf0   0x100  <Block>
    ABT_STACK          uninit   0x40000cf0   0x100  <Block tail>
                              - 0x40000df0   0x700

"P4", part 2 of 3:                           0x138
  P4 s0                         0x40000df0   0x138  <Init block>
    .data              inited   0x40000df0    0x3c  usb_istr.o [1]
    .data              inited   0x40000e2c    0x3c  usb_istr.o [1]
    .data              inited   0x40000e68    0x30  usb_prop.o [1]
    .data              inited   0x40000e98    0x28  usb_prop.o [1]
    .data              inited   0x40000ec0    0x24  usb_prop.o [1]
    .data              inited   0x40000ee4    0x14  75x_can.o [1]
    .data              inited   0x40000ef8    0x14  usb_desc.o [1]
    .data              inited   0x40000f0c     0x8  usb_prop.o [1]
    .data              inited   0x40000f14     0x8  usb_prop.o [1]
    .data              inited   0x40000f1c     0x8  usb_prop.o [1]
    .data              inited   0x40000f24     0x4  usb_prop.o [1]
                              - 0x40000f28   0x138

"P4", part 3 of 3:                           0xd94
  .bss                 zero     0x40000f28   0x608  lists.o [1]
  .bss                 zero     0x40001530   0x608  lists.o [1]
  .bss                 zero     0x40001b38    0xa4  main.o [1]
  .bss                 zero     0x40001bdc    0x40  main.o [1]
  .bss                 zero     0x40001c1c    0x40  main.o [1]
  .bss                 zero     0x40001c5c    0x28  usb_init.o [1]
  .bss                 zero     0x40001c84     0xc  hw_config.o [1]
  .bss                 zero     0x40001c90     0x6  leds.o [1]
  .bss                 zero     0x40001c98     0x4  75x_it.o [1]
  .bss                 zero     0x40001c9c     0x4  hw_config.o [1]
  .bss                 zero     0x40001ca0     0x4  usb_core.o [1]
  .bss                 zero     0x40001ca4     0x4  usb_core.o [1]
  .bss                 zero     0x40001ca8     0x4  iarwstd.o [5]
  .bss                 zero     0x40001cac     0x4  usb_int.o [1]
  .bss                 zero     0x40001cb0     0x2  main.o [1]
  .bss                 zero     0x40001cb2     0x2  usb_init.o [1]
  .bss                 zero     0x40001cb4     0x2  usb_istr.o [1]
  .bss                 zero     0x40001cb6     0x1  hw_config.o [1]
  .bss                 zero     0x40001cb7     0x1  main.o [1]
  .bss                 zero     0x40001cb8     0x1  main.o [1]
  .bss                 zero     0x40001cb9     0x1  usb_init.o [1]
  .bss                 zero     0x40001cba     0x1  usb_pwr.o [1]
                              - 0x40001cbb   0xd93


*******************************************************************************
*** INIT TABLE
***

          Address     Size
          -------     ----
Zero (__iar_zero_init2)
    1 destination range, total size 0xd93:
          0x40000f28  0xd93

Copy (__iar_copy_init2)
    1 source range, total size 0x6f0 (100% of destination):
          0x20006000  0x6f0
    1 destination range, total size 0x6f0:
          0x40000000  0x6f0

Copy (__iar_copy_init2)
    1 source range, total size 0x138 (100% of destination):
          0x2000aac0  0x138
    1 destination range, total size 0x138:
          0x40000df0  0x138


*******************************************************************************
*** MODULE SUMMARY
***

    Module            ro code  rw code  ro data  rw data
    ------            -------  -------  -------  -------
C:\Users\Ged\Documents\Work\USB2CAN\Firmware\IAR\Debug\Obj: [1]
    75x_can.o           1 588                20       20
    75x_cfg.o              32
    75x_eic.o             152
    75x_gpio.o            528
    75x_init.o            284
    75x_it.o              452                          4
    75x_mrcc.o          1 584
    75x_tb.o              384
    75x_vect.o                   1 776    1 776
    75x_wdg.o             132
    Checksum.o             76               512
    commands.o            568
    configuration.o                                   12
    hw_config.o           936                         17
    leds.o                756                          6
    lists.o               340                      3 088
    low_level_init.o        8
    main.o                936                        296
    messages.o          1 264
    usb_core.o          3 372                          8
    usb_desc.o                              160       20
    usb_endp.o             56
    usb_init.o             52                         43
    usb_int.o             668                          4
    usb_istr.o            144               120      122
    usb_mem.o             100
    usb_prop.o            880               152      152
    usb_pwr.o              72                          1
    usb_regs.o            756
    ----------------------------------------------------
    Total:             16 120    1 776    2 740    3 793

command line: [2]
    ----------------------------------------------------
    Total:

dl4t_al_in.a: [3]
    exit.o                  8
    ----------------------------------------------------
    Total:                  8

rt4t_al.a: [4]
    ABImemcpy.o           212
    cexit.o                16
    cmain.o                36
    copy_init2.o           44
    data_init2.o           56
    uread4.o               32
    zero_init2.o           40
    ----------------------------------------------------
    Total:                436

shs_l.a: [5]
    exit.o                 32
    iarwstd.o              52                          4
    xreturnswi.o            4
    ----------------------------------------------------
    Total:                 88                          4

    Gaps                                               2
    Linker created                           56    1 792
--------------------------------------------------------
    Grand Total:       16 652    1 776    2 798    5 591


*******************************************************************************
*** ENTRY LIST
***

Entry                      Address   Size  Type      Object
-----                      -------   ----  ----      ------
?main                   0x2000a9a8         Code  Gb  cmain.o [4]
ABT_STACK$$Base         0x40000cf0          --   Gb  - Linker created -
ABT_STACK$$Limit        0x40000df0          --   Gb  - Linker created -
ADC_IRQHandler          0x2000a070    0x4  Code  Gb  75x_it.o [1]
Abort_Handler           0x20009f0c    0x4  Code  Gb  75x_it.o [1]
ByteSwap                0x20009608   0x10  Code  Gb  usb_regs.o [1]
CAN_Config              0x2000878c   0xd0  Code  Gb  hw_config.o [1]
CAN_DISABLE             0x20008860   0x18  Code  Gb  hw_config.o [1]
CAN_DeInit              0x2000741c   0x20  Code  Gb  75x_can.o [1]
CAN_ENABLE              0x2000885c    0x4  Code  Gb  hw_config.o [1]
CAN_EnterInitMode       0x20007978   0x1c  Code  Gb  75x_can.o [1]
CAN_EnterTestMode       0x200079ac   0x24  Code  Gb  75x_can.o [1]
CAN_IRQHandler          0x20009f68  0x100  Code  Gb  75x_it.o [1]
CAN_Init                0x2000743c   0x40  Code  Gb  75x_can.o [1]
CAN_InvalidateAllMsgObj
                        0x20007710   0x24  Code  Gb  75x_can.o [1]
CAN_IsMessageWaiting    0x20007a24    0x8  Code  Gb  75x_can.o [1]
CAN_IsTransmitRequested
                        0x20007a2c    0x4  Code  Gb  75x_can.o [1]
CAN_LeaveInitMode       0x20007994   0x18  Code  Gb  75x_can.o [1]
CAN_LeaveTestMode       0x200079d0   0x30  Code  Gb  75x_can.o [1]
CAN_ReceiveMessage      0x20007850  0x128  Code  Gb  75x_can.o [1]
CAN_ReleaseRxMessage    0x20007a08    0x4  Code  Gb  75x_can.o [1]
CAN_ReleaseTxMessage    0x20007a00    0x8  Code  Gb  75x_can.o [1]
CAN_SendMessage         0x20007744  0x10c  Code  Gb  75x_can.o [1]
CAN_SetBitrate          0x2000747c   0x24  Code  Gb  75x_can.o [1]
CAN_SetRxMsgObj         0x20007608  0x108  Code  Gb  75x_can.o [1]
CAN_SetTiming           0x200074a4   0x5c  Code  Gb  75x_can.o [1]
CAN_SetTxMsgObj         0x20007570   0x98  Code  Gb  75x_can.o [1]
CAN_SetUnusedMsgObj     0x20007500   0x70  Code  Gb  75x_can.o [1]
CANtoUSBdata            0x20008148  0x108  Code  Gb  messages.o [1]
CFG_USBFilterConfig     0x2000aa24   0x20  Code  Gb  75x_cfg.o [1]
CSTACK$$Base            0x400006f0          --   Gb  - Linker created -
CSTACK$$Limit           0x400008f0          --   Gb  - Linker created -
CTR_HP                  0x200097ec   0xb4  Code  Gb  usb_int.o [1]
CTR_LP                  0x20009618  0x1d4  Code  Gb  usb_int.o [1]
CanListClear            0x2000a244         Code  Gb  lists.o [1]
CanListGet              0x2000a308   0x8c  Code  Gb  lists.o [1]
CanListInit             0x2000a240    0x4  Code  Gb  lists.o [1]
CanListPut              0x2000a278   0x90  Code  Gb  lists.o [1]
CanRXlist               0x40000f28  0x608  Data  Gb  lists.o [1]
CanTXlist               0x40001530  0x608  Data  Gb  lists.o [1]
CanTimings              0x40000ee4   0x14  Data  Gb  75x_can.o [1]
ClearDTOG_RX            0x20009428   0x30  Code  Gb  usb_regs.o [1]
ClearDTOG_TX            0x20009458   0x30  Code  Gb  usb_regs.o [1]
Clear_Status_Out        0x20009400   0x18  Code  Gb  usb_regs.o [1]
Config_Descriptor       0x40000f1c    0x8  Data  Gb  usb_prop.o [1]
DMA_IRQHandler          0x2000a074    0x4  Code  Gb  75x_it.o [1]
DataStageIn             0x20006cb4   0xd4  Code  Gb  usb_core.o [1]
DataStageOut            0x20006b98  0x11c  Code  Gb  usb_core.o [1]
Data_Setup0             0x20006ef8  0x298  Code  Gb  usb_core.o [1]
Device_Descriptor       0x40000f14    0x8  Data  Gb  usb_prop.o [1]
Device_Info             0x40001c5c   0x1c  Data  Gb  usb_init.o [1]
Device_Property         0x40000e68   0x30  Data  Gb  usb_prop.o [1]
Device_Table            0x40000f24    0x4  Data  Gb  usb_prop.o [1]
EIC_IRQCmd              0x2000a5fc   0x20  Code  Gb  75x_eic.o [1]
EIC_IRQInit             0x2000a584   0x78  Code  Gb  75x_eic.o [1]
EIC_IRQInitStructure    0x40001c9c    0x4  Data  Gb  hw_config.o [1]
EP1_IN_Callback         0x2000a838    0x8  Code  Gb  usb_endp.o [1]
EP1_busy                0x40001b78    0x1  Data  Gb  main.o [1]
EP2_OUT_Callback        0x2000a828    0xc  Code  Gb  usb_endp.o [1]
EP2_dataReady           0x40001b79    0x1  Data  Gb  main.o [1]
EP3_IN_Callback         0x2000a848    0xc  Code  Gb  usb_endp.o [1]
EP4_OUT_Callback        0x2000a834    0x4  Code  Gb  usb_endp.o [1]
EPindex                 0x40001cb9    0x1  Data  Gb  usb_init.o [1]
EXTIT_IRQHandler        0x2000a078    0x4  Code  Gb  75x_it.o [1]
ErrLec                  0x40001b72    0x1  Data  Gb  main.o [1]
ErrLecNext              0x40001b73    0x1  Data  Gb  main.o [1]
ErrStatus               0x40001b70    0x1  Data  Gb  main.o [1]
ErrStatusNext           0x40001b71    0x1  Data  Gb  main.o [1]
FIQ_Handler             0x20009f00    0x4  Code  Gb  75x_it.o [1]
FIQ_STACK$$Base         0x40000af0          --   Gb  - Linker created -
FIQ_STACK$$Limit        0x40000bf0          --   Gb  - Linker created -
FLASHSMI_IRQHandler     0x2000a080    0x4  Code  Gb  75x_it.o [1]
GPIO_DeInit             0x20009aec   0x1c  Code  Gb  75x_gpio.o [1]
GPIO_Init               0x20009b08  0x1dc  Code  Gb  75x_gpio.o [1]
GPIO_WriteBit           0x20009ce4   0x18  Code  Gb  75x_gpio.o [1]
GetEPDblBuf0Addr        0x200095c0         Code  Gb  usb_regs.o [1]
GetEPRxAddr             0x200094c0   0x20  Code  Gb  usb_regs.o [1]
GetEPRxCount            0x20009570   0x20  Code  Gb  usb_regs.o [1]
GetEPTxAddr             0x200094bc    0x4  Code  Gb  usb_regs.o [1]
GetUSBcmd               0x20008250  0x29c  Code  Gb  messages.o [1]
GlobalTick              0x40001c98    0x4  Data  Gb  75x_it.o [1]
I2C_IRQHandler          0x20009f50    0x4  Code  Gb  75x_it.o [1]
IRQ_STACK$$Base         0x400009f0          --   Gb  - Linker created -
IRQ_STACK$$Limit        0x40000af0          --   Gb  - Linker created -
In0_Process             0x20007248   0x8c  Code  Gb  usb_core.o [1]
IntVec$$Base            0x40000000          --   Gb  - Linker created -
IntVec$$Limit           0x400006f0          --   Gb  - Linker created -
IntVecInit$$Base        0x20006000          --   Gb  - Linker created -
IntVecInit$$Limit       0x200066f0          --   Gb  - Linker created -
MRCC_CKSYSConfig        0x20007b30  0x1b4  Code  Gb  75x_mrcc.o [1]
MRCC_CKTIMConfig        0x20007cfc   0x18  Code  Gb  75x_mrcc.o [1]
MRCC_CKUSBConfig        0x20007d30   0x54  Code  Gb  75x_mrcc.o [1]
MRCC_ClearFlag          0x20007e3c   0x78  Code  Gb  75x_mrcc.o [1]
MRCC_DeInit             0x20007a50   0xe0  Code  Gb  75x_mrcc.o [1]
MRCC_GetFlagStatus      0x20007de0   0x5c  Code  Gb  75x_mrcc.o [1]
MRCC_HCLKConfig         0x20007ce4   0x18  Code  Gb  75x_mrcc.o [1]
MRCC_IOVoltageRangeConfig
                        0x20007db8   0x1c  Code  Gb  75x_mrcc.o [1]
MRCC_IRQHandler         0x2000a07c    0x4  Code  Gb  75x_it.o [1]
MRCC_ITConfig           0x20007d84    0x8  Code  Gb  75x_mrcc.o [1]
MRCC_PCLKConfig         0x20007d14   0x1c  Code  Gb  75x_mrcc.o [1]
MRCC_PeripheralClockConfig
                        0x20007d8c    0x4  Code  Gb  75x_mrcc.o [1]
MRCC_PeripheralSWResetConfig
                        0x20007dac    0x8  Code  Gb  75x_mrcc.o [1]
MRCC_WaitForOSC4MStartUp
                        0x20007ec0   0x54  Code  Gb  75x_mrcc.o [1]
NOP_Process             0x20007418    0x4  Code  Gb  usb_core.o [1]
NoData_Setup0           0x20006d88  0x170  Code  Gb  usb_core.o [1]
OSC4MStartUpStatus      0x40001cb6    0x1  Data  Gb  hw_config.o [1]
Out0_Process            0x200072d4   0x5c  Code  Gb  usb_core.o [1]
PMAToUserBufferCopy     0x2000a768   0x2c  Code  Gb  usb_mem.o [1]
PWM_EM_IRQHandler       0x20009f48    0x4  Code  Gb  75x_it.o [1]
PWM_OC123_IRQHandler    0x20009f44    0x4  Code  Gb  75x_it.o [1]
PWM_UP_IRQHandler       0x20009f4c    0x4  Code  Gb  75x_it.o [1]
Post0_Process           0x20007330   0x58  Code  Gb  usb_core.o [1]
PowerOn                 0x2000a7e0   0x44  Code  Gb  usb_pwr.o [1]
Prefetch_Handler        0x20009f08    0x4  Code  Gb  75x_it.o [1]
RTC_IRQHandler          0x2000a084    0x4  Code  Gb  75x_it.o [1]
Region$$Table$$Base     0x2000a9cc          --   Gb  - Linker created -
Region$$Table$$Limit    0x2000aa04          --   Gb  - Linker created -
Reset_Device            0x200088d0   0x48  Code  Gb  hw_config.o [1]
RxCanMsgList            0x40001b7c   0x48  Data  Gb  main.o [1]
RxMsgCnt                0x40001b76    0x1  Data  Gb  main.o [1]
SSP0_IRQHandler         0x20009f58    0x4  Code  Gb  75x_it.o [1]
SSP1_IRQHandler         0x20009f54    0x4  Code  Gb  75x_it.o [1]
SVC_STACK$$Base         0x400008f0          --   Gb  - Linker created -
SVC_STACK$$Limit        0x400009f0          --   Gb  - Linker created -
SWI_Handler             0x20009f04    0x4  Code  Gb  75x_it.o [1]
SaveRState              0x40001cac    0x2  Data  Gb  usb_int.o [1]
SaveTState              0x40001cae    0x2  Data  Gb  usb_int.o [1]
SendErrorMessage        0x200084ec   0x64  Code  Gb  messages.o [1]
SetBTABLE               0x20009330   0x14  Code  Gb  usb_regs.o [1]
SetCKSYS_OSC4MPLL       0x20007f14  0x140  Code  Lc  75x_mrcc.o [1]
SetDeviceAddress        0x20007388   0x60  Code  Gb  usb_core.o [1]
SetEPDblBuf0Addr        0x20009590         Code  Gb  usb_regs.o [1]
SetEPRxAddr             0x2000949c   0x20  Code  Gb  usb_regs.o [1]
SetEPRxCount            0x20009504   0x24  Code  Gb  usb_regs.o [1]
SetEPRxStatus           0x20009388   0x28  Code  Gb  usb_regs.o [1]
SetEPRxValid            0x200093e0   0x20  Code  Gb  usb_regs.o [1]
SetEPTxAddr             0x20009498    0x4  Code  Gb  usb_regs.o [1]
SetEPTxCount            0x200094e0   0x24  Code  Gb  usb_regs.o [1]
SetEPTxStatus           0x2000935c   0x2c  Code  Gb  usb_regs.o [1]
SetEPTxValid            0x200093c0   0x20  Code  Gb  usb_regs.o [1]
SetEPType               0x20009344   0x18  Code  Gb  usb_regs.o [1]
Set_System              0x20008570  0x178  Code  Gb  hw_config.o [1]
Set_TB                  0x20008878   0x48  Code  Gb  hw_config.o [1]
Set_USBClock            0x200086e8   0x18  Code  Gb  hw_config.o [1]
Setup0_Process          0x20007190   0xb8  Code  Gb  usb_core.o [1]
Standard_ClearFeature   0x20006944  0x130  Code  Gb  usb_core.o [1]
Standard_GetConfiguration
                        0x200066f0   0x48  Code  Gb  usb_core.o [1]
Standard_GetDescriptorData
                        0x20006b64   0x34  Code  Gb  usb_core.o [1]
Standard_GetInterface   0x20006798   0x48  Code  Gb  usb_core.o [1]
Standard_GetStatus      0x20006870   0xd4  Code  Gb  usb_core.o [1]
Standard_SetConfiguration
                        0x20006738   0x60  Code  Gb  usb_core.o [1]
Standard_SetDeviceFeature
                        0x20006b2c   0x38  Code  Gb  usb_core.o [1]
Standard_SetEndPointFeature
                        0x20006a74   0xb8  Code  Gb  usb_core.o [1]
Standard_SetInterface   0x200067e0   0x90  Code  Gb  usb_core.o [1]
Statistics              0x40001b54   0x1c  Data  Gb  main.o [1]
StatisticsInit          0x20008918   0x28  Code  Gb  main.o [1]
StatusInfo              0x40001ca0    0x4  Data  Gb  usb_core.o [1]
String_Descriptor       0x40000e98   0x28  Data  Gb  usb_prop.o [1]
TB_ClearITPendingBit    0x2000a224   0x1c  Code  Gb  75x_tb.o [1]
TB_Cmd                  0x2000a160   0x1c  Code  Gb  75x_tb.o [1]
TB_IRQHandler           0x2000a088   0x24  Code  Gb  75x_it.o [1]
TB_ITConfig             0x2000a17c   0x9c  Code  Gb  75x_tb.o [1]
TB_Init                 0x2000a0c0   0xa0  Code  Gb  75x_tb.o [1]
TB_InitStructure        0x40001c84    0xc  Data  Gb  hw_config.o [1]
TIM0_IC12_IRQHandler    0x20009f3c    0x4  Code  Gb  75x_it.o [1]
TIM0_OC1_IRQHandler     0x20009f38    0x4  Code  Gb  75x_it.o [1]
TIM0_OC2_IRQHandler     0x20009f34    0x4  Code  Gb  75x_it.o [1]
TIM0_UP_IRQHandler      0x20009f40    0x4  Code  Gb  75x_it.o [1]
TIM1_IC12_IRQHandler    0x20009f2c    0x4  Code  Gb  75x_it.o [1]
TIM1_OC1_IRQHandler     0x20009f28    0x4  Code  Gb  75x_it.o [1]
TIM1_OC2_IRQHandler     0x20009f24    0x4  Code  Gb  75x_it.o [1]
TIM1_UP_IRQHandler      0x20009f30    0x4  Code  Gb  75x_it.o [1]
TIM2_IC12_IRQHandler    0x20009f1c    0x4  Code  Gb  75x_it.o [1]
TIM2_OC1_IRQHandler     0x20009f18    0x4  Code  Gb  75x_it.o [1]
TIM2_OC2_IRQHandler     0x20009f14    0x4  Code  Gb  75x_it.o [1]
TIM2_UP_IRQHandler      0x20009f20    0x4  Code  Gb  75x_it.o [1]
TmpCanMsg               0x40001bc4   0x18  Data  Gb  main.o [1]
TxCanFlag               0x40001b77    0x1  Data  Gb  main.o [1]
TxCanMsg                0x40001b3c   0x18  Data  Gb  main.o [1]
UART0_IRQHandler        0x20009f64    0x4  Code  Gb  75x_it.o [1]
UART1_IRQHandler        0x20009f60    0x4  Code  Gb  75x_it.o [1]
UART2_IRQHandler        0x20009f5c    0x4  Code  Gb  75x_it.o [1]
UND_STACK$$Base         0x40000bf0          --   Gb  - Linker created -
UND_STACK$$Limit        0x40000cf0          --   Gb  - Linker created -
USB2CAN_close           0x200099f0    0x4  Code  Gb  commands.o [1]
USB2CAN_get_statistics  0x20009a3c   0x94  Code  Gb  commands.o [1]
USB2CAN_get_status      0x200099f4   0x48  Code  Gb  commands.o [1]
USB2CAN_next_status     0x40001cb0    0x2  Data  Gb  main.o [1]
USB2CAN_open            0x20009970   0x80  Code  Gb  commands.o [1]
USB2CAN_reset           0x200098b4    0x4  Code  Gb  commands.o [1]
USB2CAN_set_speed       0x200098b8   0xb8  Code  Gb  commands.o [1]
USB2CAN_status          0x40001b38    0x2  Data  Gb  main.o [1]
USB_Cable_Config        0x2000876c   0x20  Code  Gb  hw_config.o [1]
USB_HP_IRQHandler       0x2000a06c    0x4  Code  Gb  75x_it.o [1]
USB_Init                0x2000a898   0x34  Code  Gb  usb_init.o [1]
USB_Interrupts_Config   0x20008700   0x6c  Code  Gb  hw_config.o [1]
USB_Istr                0x2000a61c   0x90  Code  Gb  usb_istr.o [1]
USB_LP_IRQHandler       0x2000a068    0x4  Code  Gb  75x_it.o [1]
USBdataCANmsg           0x20008080   0xc8  Code  Gb  messages.o [1]
Undefined_Handler       0x20009efc    0x4  Code  Gb  75x_it.o [1]
UserToPMABufferCopy     0x2000a730   0x38  Code  Gb  usb_mem.o [1]
User_Standard_Requests  0x40000ec0   0x24  Data  Gb  usb_prop.o [1]
Virtual_Com_Port_ConfigDescriptor
                        0x2000a900   0x30  Data  Gb  usb_desc.o [1]
Virtual_Com_Port_Data_Setup
                        0x20008eb0   0x8c  Code  Gb  usb_prop.o [1]
Virtual_Com_Port_DeviceDescriptor
                        0x2000aa84   0x14  Data  Gb  usb_desc.o [1]
Virtual_Com_Port_GetConfigDescriptor
                        0x20008f78    0x8  Code  Gb  usb_prop.o [1]
Virtual_Com_Port_GetDeviceDescriptor
                        0x20008f70    0x8  Code  Gb  usb_prop.o [1]
Virtual_Com_Port_GetLineCoding
                        0x20008fbc   0x14  Code  Gb  usb_prop.o [1]
Virtual_Com_Port_GetStringDescriptor
                        0x20008f80   0x20  Code  Gb  usb_prop.o [1]
Virtual_Com_Port_Get_Interface_Setting
                        0x20008fa0   0x1c  Code  Gb  usb_prop.o [1]
Virtual_Com_Port_NoData_Setup
                        0x20008f3c   0x34  Code  Gb  usb_prop.o [1]
Virtual_Com_Port_Reset  0x20008d3c  0x16c  Code  Gb  usb_prop.o [1]
Virtual_Com_Port_SetLineCoding
                        0x20008fd0   0x14  Code  Gb  usb_prop.o [1]
Virtual_Com_Port_Status_In
                        0x20008ea8    0x4  Code  Gb  usb_prop.o [1]
Virtual_Com_Port_Status_Out
                        0x20008eac    0x4  Code  Gb  usb_prop.o [1]
Virtual_Com_Port_StringLangID
                        0x2000aab8    0x4  Data  Gb  usb_desc.o [1]
Virtual_Com_Port_StringProduct
                        0x2000a984   0x24  Data  Gb  usb_desc.o [1]
Virtual_Com_Port_StringSerial
                        0x40000ef8   0x14  Data  Gb  usb_desc.o [1]
Virtual_Com_Port_StringVendor
                        0x2000aa04   0x20  Data  Gb  usb_desc.o [1]
Virtual_Com_Port_init   0x20008cc0   0x7c  Code  Gb  usb_prop.o [1]
WAKUP_Addr              0x40000040         Code  Gb  75x_vect.o [1]
WAKUP_IRQHandler        0x20009f10    0x4  Code  Gb  75x_it.o [1]
WDG_Cmd                 0x2000a6cc   0x4c  Code  Gb  75x_wdg.o [1]
WDG_Init                0x2000a6ac   0x20  Code  Gb  75x_wdg.o [1]
WriteCKOSCSELBit        0x20008054   0x1c  Code  Lc  75x_mrcc.o [1]
__aeabi_memcpy          0x2000a4b0         Code  Gb  ABImemcpy.o [4]
__aeabi_memcpy4         0x2000a4d4         Code  Gb  ABImemcpy.o [4]
__aeabi_memcpy8         0x2000a4d4         Code  Gb  ABImemcpy.o [4]
__aeabi_uread4          0x2000aa44         Code  Gb  uread4.o [4]
__checksum              0x2000bffe    0x2  Data  Gb  Place holder __checksum
__checksum_begin        0x20006000          --   Gb  command line/config [2]
__checksum_end          0x2000bffb          --   Gb  command line/config [2]
__exit                  0x2000aa64   0x20  Code  Gb  exit.o [5]
__iar_copy_init2        0x2000a930   0x2c  Code  Gb  copy_init2.o [4]
__iar_data_init2        0x2000a860   0x38  Code  Gb  data_init2.o [4]
__iar_program_start     0x2000a394         Code  Gb  75x_init.o [1]
__iar_return_from_swi   0x2000aabc    0x4  Code  Gb  xreturnswi.o [5]
__iar_sh_stdout_close   0x2000a8cc   0x30  Code  Gb  iarwstd.o [5]
__iar_sh_stdout_handle  0x40001ca8    0x4  Data  Lc  iarwstd.o [5]
__iar_zero_init2        0x2000a95c   0x28  Code  Gb  zero_init2.o [4]
__low_level_init        0x2000aaa8    0x8  Code  Gb  low_level_init.o [1]
_exit                   0x2000aa98         Code  Gb  cexit.o [4]
bDeviceState            0x40001cba    0x1  Data  Gb  usb_pwr.o [1]
bRun                    0x40001b74    0x1  Data  Gb  main.o [1]
bRunNext                0x40001b75    0x1  Data  Gb  main.o [1]
blink                   0x200090bc  0x264  Code  Gb  leds.o [1]
blink_state             0x40001c94    0x1  Data  Gb  leds.o [1]
blink_state_time        0x40001c90    0x4  Data  Gb  leds.o [1]
blink_type              0x40001c95    0x1  Data  Gb  leds.o [1]
buffer_cmd_in           0x40001c1c   0x40  Data  Gb  main.o [1]
buffer_cmd_out          0x40001bdc   0x40  Data  Gb  main.o [1]
conf                    0x200c0000    0xc  Data  Gb  configuration.o [1]
count_cmd_in            0x40001cb8    0x1  Data  Gb  main.o [1]
count_cmd_out           0x40001cb7    0x1  Data  Gb  main.o [1]
crc16_table             0x20009cfc  0x200  Data  Gb  Checksum.o [1]
exit                    0x2000aab0    0x8  Code  Gb  exit.o [3]
fast_crc16              0x2000a794   0x48  Code  Gb  Checksum.o [1]
ledOff                  0x2000906c   0x3c  Code  Gb  leds.o [1]
ledOn                   0x20009030   0x3c  Code  Gb  leds.o [1]
linecoding              0x40000f0c    0x8  Data  Gb  usb_prop.o [1]
main                    0x20008940  0x360  Code  Gb  main.o [1]
pEpInt_IN               0x40000df0   0x3c  Data  Gb  usb_istr.o [1]
pEpInt_OUT              0x40000e2c   0x3c  Data  Gb  usb_istr.o [1]
pInformation            0x40001c78    0x4  Data  Gb  usb_init.o [1]
pProperty               0x40001c7c    0x4  Data  Gb  usb_init.o [1]
pUser_Standard_Requests
                        0x40001c80    0x4  Data  Gb  usb_init.o [1]
setBlinkType            0x200090a8   0x14  Code  Gb  leds.o [1]
sum                     0x40001b3a    0x2  Data  Gb  main.o [1]
wInterrupt_Mask         0x40001cb2    0x2  Data  Gb  usb_init.o [1]
wIstr                   0x40001cb4    0x2  Data  Gb  usb_istr.o [1]


[1] = C:\Users\Ged\Documents\Work\USB2CAN\Firmware\IAR\Debug\Obj
[2] = command line
[3] = dl4t_al_in.a
[4] = rt4t_al.a
[5] = shs_l.a

  16 652 bytes of readonly  code memory
   1 776 bytes of readwrite code memory
   2 798 bytes of readonly  data memory
   5 591 bytes of readwrite data memory

Errors: none
Warnings: none

--------------040902020107030903070708--
