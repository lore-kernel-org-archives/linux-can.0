From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Janz ICAN3 build warnings
Date: Wed, 29 Jan 2014 15:10:51 +0100
Message-ID: <52E90BEB.9040608@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:31562 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141AbaA2OK5 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 29 Jan 2014 09:10:57 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello Ira,

while addressing an issue with the skb->sk handling here

	http://marc.info/?l=3Dlinux-netdev&m=3D139100313304453&w=3D2

I was enabling the Janz ICAN3 driver to be built as I did a small chang=
e
there too.

Can you please fix these build warnings below?

Regards,
Oliver


  CC [M]  drivers/net/can/janz-ican3.o
drivers/net/can/janz-ican3.c:1086:43: warning: =91msg.data[6]=92 may be=
 used uninitialized in this function [-Wmaybe-uninitialized]
   mod->termination_enabled =3D msg->data[6] & HWCONF_TERMINATE_ON;
                                           ^
drivers/net/can/janz-ican3.c:1320:20: note: =91msg.data[6]=92 was decla=
red here
   struct ican3_msg msg;
                    ^
drivers/net/can/janz-ican3.c:1067:15: warning: =91msg.data[5]=92 may be=
 used uninitialized in this function [-Wmaybe-uninitialized]
   cf->data[6] =3D txerr;
               ^
drivers/net/can/janz-ican3.c:1320:20: note: =91msg.data[5]=92 was decla=
red here
   struct ican3_msg msg;
                    ^
drivers/net/can/janz-ican3.c:1068:15: warning: =91msg.data[4]=92 may be=
 used uninitialized in this function [-Wmaybe-uninitialized]
   cf->data[7] =3D rxerr;
               ^
drivers/net/can/janz-ican3.c:1320:20: note: =91msg.data[4]=92 was decla=
red here
   struct ican3_msg msg;
                    ^
drivers/net/can/janz-ican3.c:1014:21: warning: =91msg.data[3]=92 may be=
 used uninitialized in this function [-Wmaybe-uninitialized]
   } else if (status & SR_ES) {
                     ^
drivers/net/can/janz-ican3.c:1320:20: note: =91msg.data[3]=92 was decla=
red here
   struct ican3_msg msg;
                    ^
drivers/net/can/janz-ican3.c:1045:13: warning: =91msg.data[2]=92 may be=
 used uninitialized in this function [-Wmaybe-uninitialized]
   if (!(ecc & ECC_DIR))
             ^
drivers/net/can/janz-ican3.c:1320:20: note: =91msg.data[2]=92 was decla=
red here
   struct ican3_msg msg;
                    ^
drivers/net/can/janz-ican3.c:940:5: warning: =91msg.data[1]=92 may be u=
sed uninitialized in this function [-Wmaybe-uninitialized]
  if (msg->data[1] !=3D CEVTIND_CHIP_SJA1000) {
     ^
drivers/net/can/janz-ican3.c:1320:20: note: =91msg.data[1]=92 was decla=
red here
   struct ican3_msg msg;
                    ^
drivers/net/can/janz-ican3.c:1025:5: warning: =91*((void *)&msg+4)=92 m=
ay be used uninitialized in this function [-Wmaybe-uninitialized]
  if (isrc =3D=3D CEVTIND_BEI) {
     ^
drivers/net/can/janz-ican3.c:1320:20: note: =91*((void *)&msg+4)=92 was=
 declared here
   struct ican3_msg msg;
                    ^
drivers/net/can/janz-ican3.c:1098:10: warning: =91msg.len=92 may be use=
d uninitialized in this function [-Wmaybe-uninitialized]
  dev_warn(mod->dev, "received unknown message: spec 0x%.2x length %d\n=
",
          ^
drivers/net/can/janz-ican3.c:1320:20: note: =91msg.len=92 was declared =
here
   struct ican3_msg msg;
                    ^
drivers/net/can/janz-ican3.c:900:5: warning: =91msg.spec=92 may be used=
 uninitialized in this function [-Wmaybe-uninitialized]
  if (msg->spec =3D=3D MSG_MSGLOST) {
     ^
drivers/net/can/janz-ican3.c:1320:20: note: =91msg.spec=92 was declared=
 here
   struct ican3_msg msg;
                    ^
