From: "Aiken, Scott" <Scott.Aiken@karlstorz.com>
Subject: RE: can acknowledgment
Date: Wed, 4 Sep 2013 20:19:48 +0000
Message-ID: <11071630B606A2488DE633430B530FDE57F07118@ELS-EX01-PV.KSTG.corp>
References: <CAJU5jUJBe49CsixJcy292Qp0VruPJo+1_FSp3FxyNFxjZDJhLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mx0.karlstorz.com ([62.134.46.134]:40864 "EHLO
	mx0.karlstorz.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753097Ab3IDU3i convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 4 Sep 2013 16:29:38 -0400
In-Reply-To: <CAJU5jUJBe49CsixJcy292Qp0VruPJo+1_FSp3FxyNFxjZDJhLQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michael Muldoon <mbmuldoon07@gmail.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Did you set the right bit rate for your network?
Do you have a bus analyzer to see if your target is trying to transmit?

This may tell you why your target isn't happy:
    int errFilter = CAN_ERR_TX_TIMEOUT |
             CAN_ERR_LOSTARB | CAN_ERR_CRTL |
             CAN_ERR_PROT | CAN_ERR_TRX | CAN_ERR_ACK |
             CAN_ERR_BUSOFF | CAN_ERR_BUSERROR |
             CAN_ERR_RESTARTED; /* see linux/can/error.h */
    setsockopt( s, SOL_CAN_RAW, &errFilter, sizeof(errFilter) );

And watch for error messages...


-----Original Message-----
From: linux-can-owner@vger.kernel.org [mailto:linux-can-owner@vger.kernel.org] On Behalf Of Michael Muldoon
Sent: Wednesday, September 04, 2013 12:48 PM
To: linux-can@vger.kernel.org
Subject: can acknowledgment

So I have a decent amount of experience with can but this is my first time using it on a linux device and therefore my first experience with socket-can.  Anyway the problem is that I am unable to view any can messages on the network without two other can devices on it currently a pcan from preak systems and an intrepid fire.  Also I'm unable to send can messages.  Everything seems to be pointing to a can acknowledgment issue which I have had experience with before but I can't seems to figure out the root cause of it here.
--
To unsubscribe from this list: send the line "unsubscribe linux-can" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
