From: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Subject: Re: [PATCH] can: ucan: add driver for Theobroma Systems UCAN devices
Date: Wed, 14 Feb 2018 17:27:17 +0100
Message-ID: <135086fe-0da8-1e0e-062a-51f7a504f382@theobroma-systems.com>
References: <20180202105949.35468-1-jakob.unterwurzacher@theobroma-systems.com>
 <629f3820-0d67-14f8-7f53-8d2035491a19@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from vegas.theobroma-systems.com ([144.76.126.164]:60231 "EHLO
        mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1032204AbeBNQ1Z (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 14 Feb 2018 11:27:25 -0500
In-Reply-To: <629f3820-0d67-14f8-7f53-8d2035491a19@grandegger.com>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org
Cc: Martin Elshuber <martin.elshuber@theobroma-systems.com>, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, Marc Kleine-Budde <mkl@pengutronix.de>

Hello Wolfgang, thanks for the review!

We are working on the code, I'll answer the errors & candump
questions in the meantime.

> - I do not see CAN error states being handled. It's
>    mandatory!

The error counters and state transitions (up to bus off) are handled on 
the device - is that what you meant? The current state is reported in 
error frames.

> Just for curiosity... what does the command
> 
> $ candump -td -e any,0:0,#FFFFFFFF
> 
> report, if you send messages
> 
> 1. with no cable connected
> 2. with CAN high and low short-circuited
> 
> And the same with "berr-reporting on".

I have tested the 4 cases, the results are pasted below in [1-4]. One 
frame is sent for each test using "cangen -n1 can0".

Best regards,
Jakob


[1] shorted, berr-reporting off

>  root@rk3399-q7:~# candump -td -e any,0:0,#FFFFFFFF
>  (000.000000)  can0  398   [1]  A5

[2] not connected, berr-reporting off

> root@rk3399-q7:~# candump -td -e any,0:0,#FFFFFFFF
>  (000.000000)  can0  294   [7]  52 46 81 66 EF FC A8

[3] shorted, berr-reporting on

> root@rk3399-q7:~# candump -td -e any,0:0,#FFFFFFFF
>  (000.000000)  can0  556   [8]  EC 54 29 3D 77 02 E9 30
>  (000.000121)  can0  20000018   [8]  00 00 08 00 00 00 10 00   ERRORFRAME
> 	protocol-violation{{tx-dominant-bit-error}{}}
> 	transceiver-status
> 	error-counter-tx-rx{{16}{0}}
>  (000.000040)  can0  20000008   [8]  00 00 08 00 00 00 38 00   ERRORFRAME
> 	protocol-violation{{tx-dominant-bit-error}{}}
> 	error-counter-tx-rx{{56}{0}}
>  (000.000055)  can0  2000000C   [8]  00 0C 08 00 00 00 68 00   ERRORFRAME
> 	controller-problem{rx-error-warning,tx-error-warning}
> 	protocol-violation{{tx-dominant-bit-error}{}}
> 	error-counter-tx-rx{{104}{0}}
>  (000.000052)  can0  2000000C   [8]  00 3C 08 00 00 00 88 00   ERRORFRAME
> 	controller-problem{rx-error-warning,tx-error-warning,rx-error-passive,tx-error-passive}
> 	protocol-violation{{tx-dominant-bit-error}{}}
> 	error-counter-tx-rx{{136}{0}}
>  (000.000203)  can0  2000001C   [8]  00 3C 08 00 00 00 90 00   ERRORFRAME
> 	controller-problem{rx-error-warning,tx-error-warning,rx-error-passive,tx-error-passive}
> 	protocol-violation{{tx-dominant-bit-error}{}}
> 	transceiver-status
> 	error-counter-tx-rx{{144}{0}}
>  (000.000188)  can0  2000001C   [8]  00 3C 08 00 00 00 98 00   ERRORFRAME
> 	controller-problem{rx-error-warning,tx-error-warning,rx-error-passive,tx-error-passive}
> 	protocol-violation{{tx-dominant-bit-error}{}}
> 	transceiver-status
> 	error-counter-tx-rx{{152}{0}}
>  (000.000210)  can0  2000001C   [8]  00 3C 08 00 00 00 A0 00   ERRORFRAME
> 	controller-problem{rx-error-warning,tx-error-warning,rx-error-passive,tx-error-passive}
> 	protocol-violation{{tx-dominant-bit-error}{}}
> 	transceiver-status
> 	error-counter-tx-rx{{160}{0}}
>  (000.000222)  can0  2000001C   [8]  00 3C 08 00 00 00 A8 00   ERRORFRAME
> 	controller-problem{rx-error-warning,tx-error-warning,rx-error-passive,tx-error-passive}
> 	protocol-violation{{tx-dominant-bit-error}{}}
> 	transceiver-status
> 	error-counter-tx-rx{{168}{0}}
>  (000.000247)  can0  2000001C   [8]  00 3C 08 00 00 00 B0 00   ERRORFRAME
> 	controller-problem{rx-error-warning,tx-error-warning,rx-error-passive,tx-error-passive}
> 	protocol-violation{{tx-dominant-bit-error}{}}
> 	transceiver-status
> 	error-counter-tx-rx{{176}{0}}
>  (000.000156)  can0  2000001C   [8]  00 3C 08 00 00 00 B8 00   ERRORFRAME
> 	controller-problem{rx-error-warning,tx-error-warning,rx-error-passive,tx-error-passive}
> 	protocol-violation{{tx-dominant-bit-error}{}}
> 	transceiver-status
> 	error-counter-tx-rx{{184}{0}}
>  (000.000218)  can0  2000001C   [8]  00 3C 08 00 00 00 C0 00   ERRORFRAME
> 	controller-problem{rx-error-warning,tx-error-warning,rx-error-passive,tx-error-passive}
> 	protocol-violation{{tx-dominant-bit-error}{}}
> 	transceiver-status
> 	error-counter-tx-rx{{192}{0}}
>  (000.000202)  can0  2000001C   [8]  00 3C 08 00 00 00 C8 00   ERRORFRAME
> 	controller-problem{rx-error-warning,tx-error-warning,rx-error-passive,tx-error-passive}
> 	protocol-violation{{tx-dominant-bit-error}{}}
> 	transceiver-status
> 	error-counter-tx-rx{{200}{0}}
>  (000.000204)  can0  2000001C   [8]  00 3C 08 00 00 00 D0 00   ERRORFRAME
> 	controller-problem{rx-error-warning,tx-error-warning,rx-error-passive,tx-error-passive}
> 	protocol-violation{{tx-dominant-bit-error}{}}
> 	transceiver-status
> 	error-counter-tx-rx{{208}{0}}
>  (000.000219)  can0  2000001C   [8]  00 3C 08 00 00 00 D8 00   ERRORFRAME
> 	controller-problem{rx-error-warning,tx-error-warning,rx-error-passive,tx-error-passive}
> 	protocol-violation{{tx-dominant-bit-error}{}}
> 	transceiver-status
> 	error-counter-tx-rx{{216}{0}}
>  (000.000194)  can0  2000001C   [8]  00 3C 08 00 00 00 E0 00   ERRORFRAME
> 	controller-problem{rx-error-warning,tx-error-warning,rx-error-passive,tx-error-passive}
> 	protocol-violation{{tx-dominant-bit-error}{}}
> 	transceiver-status
> 	error-counter-tx-rx{{224}{0}}
>  (000.000211)  can0  2000001C   [8]  00 3C 08 00 00 00 E8 00   ERRORFRAME
> 	controller-problem{rx-error-warning,tx-error-warning,rx-error-passive,tx-error-passive}
> 	protocol-violation{{tx-dominant-bit-error}{}}
> 	transceiver-status
> 	error-counter-tx-rx{{232}{0}}
>  (000.000224)  can0  2000001C   [8]  00 3C 08 00 00 00 F0 00   ERRORFRAME
> 	controller-problem{rx-error-warning,tx-error-warning,rx-error-passive,tx-error-passive}
> 	protocol-violation{{tx-dominant-bit-error}{}}
> 	transceiver-status
> 	error-counter-tx-rx{{240}{0}}
>  (000.000190)  can0  2000001C   [8]  00 3C 08 00 00 00 F8 00   ERRORFRAME
> 	controller-problem{rx-error-warning,tx-error-warning,rx-error-passive,tx-error-passive}
> 	protocol-violation{{tx-dominant-bit-error}{}}
> 	transceiver-status
> 	error-counter-tx-rx{{248}{0}}
>  (000.000214)  can0  2000005C   [8]  00 3C 08 00 00 00 F8 00   ERRORFRAME
> 	controller-problem{rx-error-warning,tx-error-warning,rx-error-passive,tx-error-passive}
> 	protocol-violation{{tx-dominant-bit-error}{}}
> 	transceiver-status
> 	bus-off
> 	error-counter-tx-rx{{248}{0}}

[4] not connected, berr-reporting on

> root@rk3399-q7:~# candump -td -e any,0:0,#FFFFFFFF | head -n 500
>  (000.000000)  can0  4BA   [5]  D0 EC D7 09 00
>  (000.000745)  can0  20000030   [8]  00 00 00 00 00 00 08 00   ERRORFRAME
> 	transceiver-status
> 	no-acknowledgement-on-tx
> 	error-counter-tx-rx{{8}{0}}
>  (000.000766)  can0  20000030   [8]  00 00 00 00 00 00 10 00   ERRORFRAME
> 	transceiver-status
> 	no-acknowledgement-on-tx
> 	error-counter-tx-rx{{16}{0}}
>  (000.000746)  can0  20000030   [8]  00 00 00 00 00 00 18 00   ERRORFRAME
> 	transceiver-status
> 	no-acknowledgement-on-tx
> 	error-counter-tx-rx{{24}{0}}
>  (000.000764)  can0  20000030   [8]  00 00 00 00 00 00 20 00   ERRORFRAME
> 	transceiver-status
> 	no-acknowledgement-on-tx
> 	error-counter-tx-rx{{32}{0}}
>  (000.000756)  can0  20000030   [8]  00 00 00 00 00 00 28 00   ERRORFRAME
> 	transceiver-status
> 	no-acknowledgement-on-tx
> 	error-counter-tx-rx{{40}{0}}
>  (000.000763)  can0  20000030   [8]  00 00 00 00 00 00 30 00   ERRORFRAME
> 	transceiver-status
> 	no-acknowledgement-on-tx
> 	error-counter-tx-rx{{48}{0}}
>  (000.000756)  can0  20000030   [8]  00 00 00 00 00 00 38 00   ERRORFRAME
> 	transceiver-status
> 	no-acknowledgement-on-tx
> 	error-counter-tx-rx{{56}{0}}
>  (000.000762)  can0  20000030   [8]  00 00 00 00 00 00 40 00   ERRORFRAME
> 	transceiver-status
> 	no-acknowledgement-on-tx
> 	error-counter-tx-rx{{64}{0}}
>  (000.000759)  can0  20000030   [8]  00 00 00 00 00 00 48 00   ERRORFRAME
> 	transceiver-status
> 	no-acknowledgement-on-tx
> 	error-counter-tx-rx{{72}{0}}
>  (000.000761)  can0  20000030   [8]  00 00 00 00 00 00 50 00   ERRORFRAME
> 	transceiver-status
> 	no-acknowledgement-on-tx
> 	error-counter-tx-rx{{80}{0}}
>  (000.000756)  can0  20000030   [8]  00 00 00 00 00 00 58 00   ERRORFRAME
> 	transceiver-status
> 	no-acknowledgement-on-tx
> 	error-counter-tx-rx{{88}{0}}
>  (000.000781)  can0  20000034   [8]  00 0C 00 00 00 00 60 00   ERRORFRAME
> 	controller-problem{rx-error-warning,tx-error-warning}
> 	transceiver-status
> 	no-acknowledgement-on-tx
> 	error-counter-tx-rx{{96}{0}}
>  (000.000768)  can0  20000034   [8]  00 0C 00 00 00 00 68 00   ERRORFRAME
> 	controller-problem{rx-error-warning,tx-error-warning}
> 	transceiver-status
> 	no-acknowledgement-on-tx
> 	error-counter-tx-rx{{104}{0}}
>  (000.000729)  can0  20000034   [8]  00 0C 00 00 00 00 70 00   ERRORFRAME
> 	controller-problem{rx-error-warning,tx-error-warning}
> 	transceiver-status
> 	no-acknowledgement-on-tx
> 	error-counter-tx-rx{{112}{0}}
>  (000.000773)  can0  20000034   [8]  00 0C 00 00 00 00 78 00   ERRORFRAME
> 	controller-problem{rx-error-warning,tx-error-warning}
> 	transceiver-status
> 	no-acknowledgement-on-tx
> 	error-counter-tx-rx{{120}{0}}
>  (000.000753)  can0  20000034   [8]  00 3C 00 00 00 00 80 00   ERRORFRAME
> 	controller-problem{rx-error-warning,tx-error-warning,rx-error-passive,tx-error-passive}
> 	transceiver-status
> 	no-acknowledgement-on-tx
> 	error-counter-tx-rx{{128}{0}}
>  (000.000828)  can0  20000024   [8]  00 3C 00 00 00 00 80 00   ERRORFRAME
> 	controller-problem{rx-error-warning,tx-error-warning,rx-error-passive,tx-error-passive}
> 	no-acknowledgement-on-tx
> 	error-counter-tx-rx{{128}{0}}
>  (000.000823)  can0  20000034   [8]  00 3C 00 00 00 00 80 00   ERRORFRAME
> 	controller-problem{rx-error-warning,tx-error-warning,rx-error-passive,tx-error-passive}
> 	transceiver-status
> 	no-acknowledgement-on-tx
> 	error-counter-tx-rx{{128}{0}}
>  (000.000823)  can0  20000034   [8]  00 3C 00 00 00 00 80 00   ERRORFRAME
> 	controller-problem{rx-error-warning,tx-error-warning,rx-error-passive,tx-error-passive}
> 	transceiver-status
> 	no-acknowledgement-on-tx
> 	error-counter-tx-rx{{128}{0}}
>  (000.000821)  can0  20000034   [8]  00 3C 00 00 00 00 80 00   ERRORFRAME
> 	controller-problem{rx-error-warning,tx-error-warning,rx-error-passive,tx-error-passive}
> 	transceiver-status
> 	no-acknowledgement-on-tx
> 	error-counter-tx-rx{{128}{0}}
>  (000.000826)  can0  20000034   [8]  00 3C 00 00 00 00 80 00   ERRORFRAME
> 	controller-problem{rx-error-warning,tx-error-warning,rx-error-passive,tx-error-passive}
> 	transceiver-status
> 	no-acknowledgement-on-tx
> 	error-counter-tx-rx{{128}{0}}
>  (000.000827)  can0  20000034   [8]  00 3C 00 00 00 00 80 00   ERRORFRAME
> 	controller-problem{rx-error-warning,tx-error-warning,rx-error-passive,tx-error-passive}
> 	transceiver-status
> 	no-acknowledgement-on-tx
> 	error-counter-tx-rx{{128}{0}}
> (repeats ad infinitum)
