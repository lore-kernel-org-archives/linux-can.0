From: <Tobias.Grueninger@Emerson.com>
Subject: iMX28 and CAN Error frames
Date: Fri, 15 Mar 2013 16:16:08 +0000
Message-ID: <1EF5AE0C0C5487498E14A50D915B97933B0A4DB586@GBLONZ-PMSGEM05.emrsn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from usstlz-psecap05.emerson.com ([144.191.128.16]:50976 "EHLO
	USSTLZ-PSECAP05.EMERSON.COM" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754411Ab3COQRB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 15 Mar 2013 12:17:01 -0400
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi,

I have trouble in receiving error frames on my freescale iMX28 board.
Linux mx28 2.6.35.3-g880e772 #35 Mon Jul 30 15:04:31 CEST 2012 armv5tej=
l GNU/Linux

In normal operation, many telegrams are received and some are sent from=
 the iMX28.

Now I want to implement the error handling. After many trials, I am now=
 out of my wisdom..

The situation is that when I craft manually an error frame and send thi=
s on my console to can0
      cansend can0 20000040#

then my application does nicely receive this: (/* are my comments)
************
      virtual void OCanModelPrivate::run(): current telegram: 0X1404224=
0 /* Normal telegram, frame.can_id & CAN_EFF_MASK
      >>>send error frame from other console
      virtual void OCanModelPrivate::run(): current telegram:=A0=A0=A0=A0=
 0X40 /* the error frame
      CAN_ERR_FLAG raised: CAN_ERR_BUSOFF /*debug output
      run: 20000040 0 - 00 00 00 00 - 00 00 00 00 /*debug output
*************

But, if I e.g. short circuit the CAN Bus to provoke a real Bus Off prob=
lem:
***********
	virtual void OCanModelPrivate::run(): current telegram: 0X140222C0
	virtual void OCanModelPrivate::run(): current telegram: 0X80422C0
	>>>CAN short circuit
	/* nothing happens..

	virtual void OCanModelPrivate::run(): no data in the last 5s /* comes =
from select() timeout
	OCanModelPrivate::run():FD_ISSET =3D=3D 0 , no data read possible from=
 CAN0: /* comes from "if (FD_ISSET(s, &rdfs)) {..} else{.."
	virtual void OCanModelPrivate::run(): no data in the last 5s
	OCanModelPrivate::run():FD_ISSET =3D=3D 0 , no data read possible from=
 CAN0:=20
	OCanModelPrivate::sendMessage:write: No buffer space available=A0 /* c=
omes from "if ((nbytes =3D write(s, &frame, sizeof(frame))) !=3D sizeof=
(frame))"
	OCanModelPrivate::sendMessage:write: No buffer space available
	virtual void OCanModelPrivate::run(): no data in the last 5s
	OCanModelPrivate::run():FD_ISSET =3D=3D 0 , no data read possible from=
 CAN0: Success
	OCanModelPrivate::sendMessage:write: No buffer space available
      OCanModelPrivate::sendMessage:write: No buffer space available
**************

The Error mask is this:
	can_err_mask_t err_mask =3D CAN_ERR_MASK;
	if ( setsockopt(d->s, SOL_CAN_RAW, CAN_RAW_ERR_FILTER, &err_mask, size=
of(err_mask)) ) {.}

Where can be searched, or what did I not understood?


Best Regards / Mit freundlichen Gr=FC=DFen / Cordialement

Tobias Gr=FCninger=20
Emerson Network Power GmbH | Niederlassung Erlangen, Schallershofer Str=
=2E 141 =A0| 91056 Erlangen

