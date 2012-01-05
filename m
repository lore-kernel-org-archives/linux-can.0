From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH net-next v2 2/4] can: cc770: add legacy ISA bus driver
 for the CC770 and AN82527
Date: Thu, 05 Jan 2012 21:48:59 +0100
Message-ID: <4F060CBB.7060003@hartkopp.net>
References: <1322214204-1121-1-git-send-email-wg@grandegger.com> <1322214204-1121-3-git-send-email-wg@grandegger.com> <4ED0FEC5.3070108@hartkopp.net> <4ED34CAD.7040000@essax.com> <4ED351A8.8000102@grandegger.com> <4ED37885.8080909@essax.com> <4ED3B198.2040308@hartkopp.net> <4ED4A2EC.40103@grandegger.com> <4EDBC05D.8070109@essax.com> <4EDBC25D.50405@grandegger.com> <4EDE8435.5080100@essax.com> <4EDF6D54.2060503@grandegger.com> <4EE1E26B.6090308@grandegger.com> <4EE4F76E.3000506@essax.com> <4EE5C824.2050704@grandegger.com> <4EE5E321.8050104@essax.com> <4EE5EBBF.6080007@grandegger.com> <4EF22625.5000109@essax.com> <4EF2FA3F.3010308@grandegger.com> <4EF32E84.1080006@essax.com> <4EFED857.3000701@essax.com> <4F044FDC.60303@grandegger.com> <4F051927.8010600@essax.com> <4F058ED5.2000407@grandegger
 .com> <4F05FDE1.1040704@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:65380 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754234Ab2AEUtO (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 5 Jan 2012 15:49:14 -0500
In-Reply-To: <4F05FDE1.1040704@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Wolfgang Zarre <info@essax.com>
Cc: linux-can@vger.kernel.org, =?ISO-8859-1?Q?Heinz-J=FCrgen_Oertel?= <oe@port.de>, Henrik W Maier <henrik@focus-sw.com>

Answering myself ...

i found out that the "HM" comment was introduced in the transition
from v3.2 to v3.3.3 . I took the compared versions from Heinz-J=FCrgen:

http://www.port.de/pages/misc/can4linux.php

The diff which contains the relevant changes is here:

diff -U 10 -w can4linux-3.2/src/can_i82527funcs.c can4linux-3.3.3/can_i=
82527funcs.c | dos2unix

--- can4linux-3.2/src/can_i82527funcs.c	2004-05-14 12:02:54.000000000 +=
0200
+++ can4linux-3.3.3/can_i82527funcs.c	2004-12-14 10:35:20.000000000 +01=
00
@@ -1,32 +1,40 @@
 /*
  * can_i82527funcs.c - i82527 related code
  *
  * Original version Written by Arnaud Westenberg email:arnaud@wanadoo.=
nl
  * This software is released under the GPL-License.
  *
+ * Modified and extended to support the esd elctronic system
+ * design gmbh PC/104-CAN Card (www.esd-electronics.com)
+ * by Jean-Jacques Tchouto (tchouto@fokus.fraunhofer.de), 2003
+ *
  * Major Refactoring and Integration into can4linux version 3.1 by
  * Henrik W Maier of FOCUS Software Engineering Pty Ltd <www.focus-sw.=
com>
  *
  * Modified and extended to support the SBS PC7compact DINrail mounted
  * industry PC by FOCUS Software Engineering Pty Ltd <www.focus-sw.com=
>
  *
- * Modified and extended to support the esd elctronic system
- * design gmbh PC/104-CAN Card (www.esd-electronics.com)
- * by Jean-Jacques Tchouto (tchouto@fokus.fraunhofer.de), 2003
+ * Updated for 2.6 kernel by Henrik W Maier of FOCUS Software
+ * Engineering Pty Ltd <www.focus-sw.com>.
+ * Bugfix in CAN_SendMessage, added wake_up_interruptible for irq_writ=
e_handler
+ * Disabled redundant status change interrupt for RX/TX to decrease in=
t
+ * load on CPU.
+ * Fixed issue of a second iteration in the ISR when sending because t=
he
+ * send interrupt didn't sometimes get acknowledged.
  *
- * $Id: can_i82527funcs.c,v 1.3 2004/05/14 10:02:54 oe Exp $
+ * $Id: can_i82527funcs.c,v 1.4 2004/12/14 09:35:20 oe Exp $
  *
  */
=20
=20
-#include <can_defs.h>
+#include "can_defs.h"
 #include "can_i82527.h"
=20
=20
 #if defined (PC104_200)
 inline void CANactivateIRQline(int bd)
 {
     unsigned long canIoPort;
     canIoPort =3D (unsigned long)Base[bd];
     outb_p(0x86, canIoPort+3);
 }
@@ -216,22 +224,22 @@
            MVAL_SET | TXIE_RES | RXIE_SET | INTPD_RES);
=20
     CAN_SetMask(board, AccCode[board], AccMask[board]);
=20
     // Clear message object for send
     CANout(board, message1Reg.msgCtrl1Reg,
            RMPD_RES | TXRQ_RES | CPUU_RES | NEWD_RES);
     CANout(board, message1Reg.msgCtrl0Reg,
            MVAL_RES | TXIE_RES | RXIE_RES | INTPD_RES);
=20
-    // Clear bus-off, Interrupts on Rx, TX, any Status change and data=
 overrun
-    CANout(board, controlReg, iCTL_IE | iCTL_SIE | iCTL_EIE);
+    // Clear bus-off, Interrupts only for errors, not for status chang=
e
+    CANout(board, controlReg, iCTL_IE | iCTL_EIE);
=20
     DBGprint(DBG_DATA, ("[%d] CAN_CON 0x%x\n", board, CANin(board, con=
trolReg)));
=20
     DBGout();
     return 0;
 }
=20
=20
 /*
  * Puts chip in bus-off mode
@@ -274,23 +282,28 @@
 int CAN_SendMessage(int board, canmsg_t *tx)
 {
     int i =3D 0;
     int ext;
     uint8_t id0, id1, id2, id3;
=20
     DBGin("i82527_CAN_SendMessage");
=20
     DBGin("Wait if there is a transmission in progress");
     // Wait if there is a transmission in progress
-    while ((CANin(board, message1Reg.msgCtrl1Reg) && TXRQ_UNC) =3D=3D =
TXRQ_SET) {
+    while ((CANin(board, message1Reg.msgCtrl1Reg) & TXRQ_UNC) =3D=3D T=
XRQ_SET) {
  	    #if LINUX_VERSION_CODE >=3D 131587
-	    if( current->need_resched ) schedule();
+	    # if LINUX_VERSION_CODE >=3D KERNEL_VERSION(2,5,0)
+	    cond_resched();
+	    # else
+	    if( current->need_resched )
+        schedule();
+	    # endif
 	    #else
 	    if( need_resched ) schedule();
 	    #endif
     }
     DBGout();
=20
     CANout(board, message1Reg.msgCtrl1Reg,
            RMPD_RES | TXRQ_RES | CPUU_SET | NEWD_SET);
     CANout(board,message1Reg.msgCtrl0Reg,
            MVAL_SET | TXIE_SET | RXIE_RES | INTPD_RES);
@@ -507,32 +520,37 @@
=20
     DBGin("i82527_irq_write_handler");
=20
     // Enter critical section
     save_flags(flags);
     cli();
=20
     if( TxFifo->free[TxFifo->tail] =3D=3D BUF_EMPTY ) {
         // Nothing more to send, switch off interrupts
         CANout(board, message1Reg.msgCtrl0Reg,
-               (MVAL_RES | TXIE_RES | RXIE_UNC | INTPD_RES));
+               (MVAL_RES | TXIE_RES | RXIE_RES | INTPD_RES));
         TxFifo->status =3D BUF_EMPTY;
         TxFifo->active =3D 0;
+        // We had some cases of repeated IRQ, so make sure the INT is =
acknowledged
+        CANout(board, message1Reg.msgCtrl0Reg,
+               (MVAL_UNC | TXIE_UNC | RXIE_UNC | INTPD_RES));
         /* leave critical section */
         restore_flags(flags);
-
+        // Notify user app
+        wake_up_interruptible(  &CanOutWait[board] );
+        DBGout();
         return;
     }
     CANout(board, message1Reg.msgCtrl1Reg,
                  RMPD_RES | TXRQ_RES | CPUU_SET | NEWD_RES);
     CANout(board, message1Reg.msgCtrl0Reg,
-                 MVAL_SET | TXIE_SET | RXIE_RES | INTPD_UNC);
+                 MVAL_SET | TXIE_SET | RXIE_RES | INTPD_RES);
=20
     tx2reg =3D (TxFifo->data[TxFifo->tail]).length;
=20
     ext =3D (TxFifo->data[TxFifo->tail]).flags & MSG_EXT;
     id =3D (TxFifo->data[TxFifo->tail]).id;
=20
     if ( ext ) {
         CANout(board, message1Reg.messageConfigReg,
                      (tx2reg << 4 ) + ( MCFG_DIR | MCFG_XTD ));
         id0 =3D (uint8_t)( id << 3 );
@@ -565,20 +583,24 @@
     }
     else {
         CANout(board, message1Reg.msgCtrl1Reg,
                (RMPD_RES | TXRQ_SET | CPUU_RES | NEWD_UNC));
=20
     }
=20
     TxFifo->free[TxFifo->tail] =3D BUF_EMPTY; /* now this entry is EMP=
TY */
     TxFifo->tail =3D ++(TxFifo->tail) % MAX_BUFSIZE;
=20
+    // HM: We had some cases of repeated IRQs, so make sure the INT is=
 acknowledged
+    // I know it's already further up, but doing again fixed the issue
+    CANout(board, message1Reg.msgCtrl0Reg,
+           (MVAL_UNC | TXIE_UNC | RXIE_UNC | INTPD_RES));
     /* leave critical section */
     restore_flags(flags);
=20
     DBGout();
 }
=20
=20
 /*
  * The plain i82527 interrupt
  *
@@ -604,32 +626,41 @@
  *
  *
  * RX Int with to Receive channels:
  * 1)                _____   ___
  *             _____|     |_|   |__
  *                   30    5  20  =C2=B5s
  *   first ISR normal length,
  *   time between the two ISR -- short
  *   sec. ISR shorter than first, why? it's the same message
  */
+#if LINUX_VERSION_CODE >=3D 0x020500
+irqreturn_t CAN_Interrupt ( int irq, void *dev_id, struct pt_regs *ptr=
egs )
+#else
 void CAN_Interrupt(int irq, void *dev_id, struct pt_regs *ptregs)
+#endif
 {
     int board =3D *(int *) dev_id;
     msg_fifo_t *RxFifo =3D &Rx_Buf[board];
     msg_fifo_t *TxFifo =3D &Tx_Buf[board];
     uint8_t irqreg;
+    uint8_t lastIrqreg;
=20
     // Read the highest pending interrupt request
     irqreg =3D CANin(board, interruptReg);
+    lastIrqreg =3D irqreg;
+   =20
     while ( irqreg ) {
-        // Handle change in status register
-        if ( irqreg =3D=3D 0x01 ) {
+        switch (irqreg)
+        {
+            case 1: // Status register
+            {
             uint8_t status;
=20
             // Read the STATUS reg
             status =3D CANin(board, statusReg);
             CANout (board, statusReg, 0);
=20
             if ( status & iSTAT_RXOK ) {
                 // Intel datasheet: Software must clear this bit in IS=
R
                 CANout (board, statusReg, status & ~iSTAT_RXOK);
             }
@@ -644,42 +675,66 @@
                 DBGprint(DBG_DATA,("i82527_CAN_Interrupt: Bus warning\=
n" ));
             }
             if ( status & iSTAT_BOFF ) {
                 long flags;
=20
                 // Note: status bit is read-only, don't clear
                 // TODO must be implemented here for chip statistic
                 (RxFifo->data[RxFifo->head]).flags +=3D MSG_BUSOFF;
=20
                 // Clear init flag and reenable interrupts
-                flags =3D CANin(board, controlReg) | ( iCTL_IE | iCTL_=
SIE | iCTL_EIE );
+                    flags =3D CANin(board, controlReg) | ( iCTL_IE | i=
CTL_EIE );
                 flags &=3D ~iCTL_INI; // Reset init flag
                 CANout(board, controlReg, flags);
=20
                 (RxFifo->data[RxFifo->head]).id =3D 0xFFFFFFFF;
                 RxFifo->status =3D BUF_OK;
                 RxFifo->head =3D ++(RxFifo->head) % MAX_BUFSIZE;
                 if(RxFifo->head =3D=3D RxFifo->tail) {
                     RxFifo->status =3D BUF_OVERRUN;
                 }
+                    // Notify user app
+                    wake_up_interruptible(  &CanWait[board] );
 	            DBGprint(DBG_DATA,("i82527_CAN_Interrupt: Bus off\n" ));
             }
-        } // end if irqreg =3D=3D 0x01
-        else {
-            if (irqreg =3D=3D 0x02)
+             }
+             break;
+             case 2: // Receiption, message object 15
                 i82527_irq_read_msg15_handler(board, RxFifo);
-            else
+             break;
+             case 3: // Write, message object 1
                 i82527_irq_write_handler(board, TxFifo);
-        } //end else if irqreg =3D=3D 0x01
+             break;
+             case 4: // message object 2
+                 //printk("*********** Unexpected i82527_CAN_Interrupt=
: irqreq2=3D0x%X\n", irqreg);
+                 DBGprint(DBG_DATA,("Unexpected i82527_CAN_Interrupt: =
irqreq=3D0x%X\n", irqreg));
+                 CANout(board, message2Reg.msgCtrl0Reg,=20
+                        (MVAL_RES | TXIE_RES | RXIE_RES | INTPD_RES));
+             break;
+             default: // Unexpected
+                 //printk("*********** Unexpected i82527_CAN_Interrupt=
: irqreq2=3D0x%X\n", irqreg);
+                 DBGprint(DBG_DATA,("Unexpected i82527_CAN_Interrupt: =
irqreq=3D0x%X\n", irqreg));
+             break;
+        }
         // Get irq status again for next loop iteration
         irqreg =3D CANin(board, interruptReg);
-    } // while
+        if (irqreg =3D=3D lastIrqreg)
+        {
+           //printk("i82527_CAN_Interrupt: irqreq repeated!!!! 0x%X\n"=
, irqreg);
+           DBGprint(DBG_DATA,("i82527_CAN_Interrupt: irqreq repeated!!=
!! 0x%X\n", irqreg));
+        }
+        lastIrqreg =3D     irqreg;
+    } /* end while (irqreq) */
+    DBGout();
+#if LINUX_VERSION_CODE >=3D 0x020500
+    return IRQ_RETVAL(IRQ_HANDLED);
+#endif
 }
=20
=20
 int CAN_ShowStat(int board)
 {
   // TODO: Implement
   return -1;
 }
=20
=20
@@ -852,21 +907,20 @@
 	/* PCI scan has already remapped the address */
 	can_base[board] =3D (unsigned char *)Base[board];
 #else
 	can_base[board] =3D ioremap(Base[board], can_range[board]);
 #endif
 #else 	  /*  LINUX_VERSION_CODE >=3D KERNEL_VERSION(2,3,11) */
=20
 /* both drivers use high memory area */
 #if !defined(CONFIG_PPC) && !defined(CAN4LINUX_PCI)
     if( check_region(Base[board], CAN_RANGE ) ) {
-		     /* MOD_DEC_USE_COUNT; */
 		     DBGout();
 		     return -EBUSY;
     } else {
 #if LINUX_VERSION_CODE >=3D KERNEL_VERSION(2,0,0)
           request_region(Base[board], can_range[board], "CAN-IO" );
 #else
           request_region(Base[board], can_range[board] );
 #endif  /* LINUX_VERSION_CODE >=3D KERNEL_VERSION(2,0,0) */
     }
 #endif /* !defined  ... */


That's it :-)

I hope it helps.

Cheers,
Oliver




On 05.01.2012 20:45, Oliver Hartkopp wrote:

> Hello Wolfgang(s),
>=20
> On 05.01.2012 12:51, Wolfgang Grandegger wrote:
>=20
>>>>> diff --git a/drivers/net/can/cc770/cc770_isa.c
>>>>> b/drivers/net/can/cc770/cc770_isa.c
>>>>> index 4be5fe2..48fc128 100644
>>>>> --- a/drivers/net/can/cc770/cc770_isa.c
>>>>> +++ b/drivers/net/can/cc770/cc770_isa.c
>>>>> @@ -148,8 +148,7 @@ static void cc770_isa_port_write_reg_indirect=
(const
>>>>> struct cc770_priv *priv,
>>>>>   {
>>>>>       unsigned long base =3D (unsigned long)priv->reg_base;
>>>>>
>>>>> -    outb(reg, base);
>>>>> -    outb(val, base + 1);
>>>>> +    outw( reg + ( val<<  8), base);
>>>>
>=20
>>>> That modification does fix your problem, right? The others above d=
on't
>>>> help nor harm but we don't know if it's really realted to the same
>>>> problem. I wll dig a bit deeper.
>>>
>>> Exactly. The others above I removed because facing the opposite, ev=
en
>>> missing interrupts but then just to avoid other possible side effec=
ts
>>> and then assuming that they might be related.
>>
>> OK. My concern: Can we be sure that 16bit accesses are always suppor=
ted
>> by the hardware? Does a spinlock_irqsave/spinlock_irqrestore around =
the
>> 8bit accesses already help?
>>
>> About the "HM:" fixes, I did not find any info in the svn log. Maybe
>> Oliver knows why they have been added.
>=20
>=20
>=20
> No, in fact i don't know 8-)
>=20
> As you can see from the initial commit msg here:
>=20
> http://svn.berlios.de/wsvn/socketcan/branches/ha/candrv/kernel/2.6/dr=
ivers/net/can/i82527/?rev=3D197&peg=3D197
>=20
> "First implementation of i82527 socketcan driver based on parts from
> socketcan sja1000 netdev / ocan hal / can4linux register access.
> Know issues: Currently only receives SFF CAN frames due different
> handling of SFF/EFF and RTR frames in opposite to the SJA1000 control=
ler."
>=20
> I took my sja1000 SocketCAN driver and tried to pick the register acc=
ess
> sniplets for the i82527 from (mostly) can4linux and kicked it until i=
t
> compiled ...
>=20
> This register access part is from can4linux which has a long(!) devel=
opment
> history too, where a special message regarding the ISR can be found, =
see:
>=20
> http://can4linux.svn.sourceforge.net/viewvc/can4linux/trunk/can4linux=
/i82527funcs.c?revision=3D36&view=3Dmarkup
>=20
> /*
>  * can_i82527funcs.c - i82527 related code
>  *
>  * Original version Written by Arnaud Westenberg email:arnaud@wanadoo=
=2Enl
>  * This software is released under the GPL-License.
>  *
>  * Modified and extended to support the esd elctronic system
>  * design gmbh PC/104-CAN Card (www.esd-electronics.com)
>  * by Jean-Jacques Tchouto (tchouto@fokus.fraunhofer.de), 2003
>  *
>  * Major Refactoring and Integration into can4linux version 3.1 by
>  * Henrik W Maier of FOCUS Software Engineering Pty Ltd <www.focus-sw=
=2Ecom>
>  *
>  * Modified and extended to support the SBS PC7compact DINrail mounte=
d
>  * industry PC by FOCUS Software Engineering Pty Ltd <www.focus-sw.co=
m>
>  *
>  * Updated for 2.6 kernel by Henrik W Maier of FOCUS Software
>  * Engineering Pty Ltd <www.focus-sw.com>.
>  * Bugfix in CAN_SendMessage, added wake_up_interruptible for irq_wri=
te_handler
>  * Disabled redundant status change interrupt for RX/TX to decrease i=
nt
>  * load on CPU.
>  * Fixed issue of a second iteration in the ISR when sending because =
the
>  * send interrupt didn't sometimes get acknowledged.
>  *
>  * $Id: i82527funcs.c,v 1.1 2006/04/21 16:26:51 oe Exp $
>  *
>  */
>=20
> My original hardware was the Eurotech COM 1274 board for the US DOT V=
II OBU:
> http://www.eurotech.com/en/download/com-1274
>=20
> Obviously the ISR quirk code was added by Henrik W Maier from FOCUS S=
oftware:
>=20
> http://www.focus-sw.com/can/can4linux.html
>=20
> Maybe Henrik or Heinz-J=FCrgen remember why this ISR handling has bee=
n added
> more than seven years ago ... i added both of them in CC.
>=20
> I hope the historical src code research helped a bit.
>=20
> Indeed i was not aware of that long i82527 history inside the can4lin=
ux
> driver. If there's any interest of the register access authors, we sh=
ould
> add some credits into the cc770 driver.
>=20
> Best regards,
> Oliver
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


