From: =?iso-8859-1?Q?St=E9phane_Grosjean?= <s.grosjean@peak-system.com>
Subject: RE: PCAN USB hardware timestamps jumps forward
Date: Tue, 12 May 2020 07:56:47 +0000
Message-ID: <DB6PR03MB3093457A77199F550EBBA84CD6BE0@DB6PR03MB3093.eurprd03.prod.outlook.com>
References: <CAArkK-dJkWCfUoTfZeXDiKSKNeey6_CwAK_gNB5QoRs=kA2O5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-eopbgr60044.outbound.protection.outlook.com ([40.107.6.44]:61250
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725889AbgELH4w (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 12 May 2020 03:56:52 -0400
In-Reply-To: <CAArkK-dJkWCfUoTfZeXDiKSKNeey6_CwAK_gNB5QoRs=kA2O5A@mail.gmail.com>
Content-Language: fr-FR
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?iso-8859-1?Q?Fabi=E1n_Inostroza?= <fabian.inostroza.p@gmail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi,

Thank you for your email. Your diagnosis is good. We will think of a way to=
 correct this case so as not to disrupt the proper functioning of other USB=
 adapters whose drivers share this code.

--- Stephane


De : linux-can-owner@vger.kernel.org <linux-can-owner@vger.kernel.org> de l=
a part de Fabi=E1n Inostroza <fabian.inostroza.p@gmail.com>

Envoy=E9 : samedi 9 mai 2020 21:05

=C0 : linux-can@vger.kernel.org <linux-can@vger.kernel.org>

Objet : PCAN USB hardware timestamps jumps forward




Hello,



I have noticed that sometimes the hardware timestamps shown by candump

jump forward, look at the following candump extract:

(0000034679.461888) can0 123#7003000000000000

(0000034682.263253) can0 123#7103000000000000

(0000034679.472170) can0 123#7203000000000000



these messages are transported in the following usb packets:

Time        Data

7.436864  02 01 08 60 24 34 7b 70 03 00 00 00 00 00 00 ...

7.441998  02 03 42 04 01 c4 7b 40 01 00 08 60 24 ad 7b 71 03 00 00 00

00 00 00 ...

7.447143  02 01 08 60 24 25 7c 72 03 00 00 00 00 00 00 ...



The time column is the time shown in Wireshark and the CAN messages

where send approx

every 5 ms.



Reading the source code of the driver I concluded that the jump is

caused because the second

usb packet contains 3 records, the first with only a timestamp, the

second record is a error record and the third contains a data record

and the timestamp of the data record is before the first record and

the driver detects this as an overflow.



I've attached a patch that fixes this, I've only tested it with PCAN

USB ver 8.3 latter upgraded to v8.4.



From 34dccd02d430b8bbb68802ab304c7e2f9f184871 Mon Sep 17 00:00:00 2001

From: Fabian Inostroza <fabianinostrozap@gmail.com>

Date: Tue, 5 May 2020 01:06:40 -0400

Subject: [PATCH] can: peak_usb: fix hardware timestamp jumps



Sometimes the adapter sends an internal record with a timestamp

captured after the timestamp contained in the following data record.

The driver interprets this as an overflow in the timestamp and produces

a jump of some seconds for the messages contained in the usb packet.



Since the adapter periodically (~1s) sends records to sync the timestamp

then this delta computed in the driver cannot be bigger than this period.

Use this to detect real overflows.



Signed-off-by: Fabian Inostroza <fabianinostrozap@gmail.com>

---

 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 12 ++++++++----

 1 file changed, 8 insertions(+), 4 deletions(-)



diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c

b/drivers/net/can/usb/peak_usb/pcan_usb_core.c

index 0b7766b71..77d734731 100644

--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c

+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c

@@ -130,12 +130,16 @@ void peak_usb_get_ts_time(struct peak_time_ref

*time_ref, u32 ts, ktime_t *time)

     /* protect from getting time before setting now */

     if (ktime_to_ns(time_ref->tv_host)) {

         u64 delta_us;

+        s64 delta =3D (s64)ts - (s64)time_ref->ts_dev_2;



-        delta_us =3D ts - time_ref->ts_dev_2;

-        if (ts < time_ref->ts_dev_2)

-            delta_us &=3D (1 << time_ref->adapter->ts_used_bits) - 1;

+        if (delta < 0) {

+            delta_us =3D delta &

+                ((1 << time_ref->adapter->ts_used_bits) - 1);

+            if (delta_us < time_ref->adapter->ts_period)

+                delta =3D delta_us;

+        }



-        delta_us +=3D time_ref->ts_total;

+        delta_us =3D delta + time_ref->ts_total;



         delta_us *=3D time_ref->adapter->us_per_ts_scale;

         delta_us >>=3D time_ref->adapter->us_per_ts_shift;

--

2.26.2


--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt - HRB 9183
Geschaeftsfuehrung: Alexander Gach / Uwe Wilhelm
Unsere Datenschutzerklaerung mit wichtigen Hinweisen
zur Behandlung personenbezogener Daten finden Sie unter
www.peak-system.com/Datenschutz.483.0.html
