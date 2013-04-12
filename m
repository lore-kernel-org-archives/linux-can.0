From: "Mylene Josserand" <Mylene.Josserand@navocap.com>
Subject: Re: [imx27 - mcp251x] MCP251x does not work in static ?
Date: Fri, 12 Apr 2013 11:40:29 +0200
Message-ID: <CA78C307B8F06747967D122FC656B15377446D@SERVEUR0.nvp.local>
References: <CA78C307B8F06747967D122FC656B153774451@SERVEUR0.nvp.local> <51656B9B.80907@pengutronix.de> <CA78C307B8F06747967D122FC656B153774455@SERVEUR0.nvp.local> <5165857D.1050303@pengutronix.de> <CA78C307B8F06747967D122FC656B15377445A@SERVEUR0.nvp.local> <51666B21.10109@pengutronix.de> <CA78C307B8F06747967D122FC656B15377445D@SERVEUR0.nvp.local> <516676B5.6090903@pengutronix.de> <CA78C307B8F06747967D122FC656B153774460@SERVEUR0.nvp.local> <51668741.6030909@pengutronix.de> <CA78C307B8F06747967D122FC656B153774467@SERVEUR0.nvp.local> <5167D584.7080800@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp-155-friday.nerim.net ([194.79.134.155]:57142 "EHLO
	maiev.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752713Ab3DLJmH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 12 Apr 2013 05:42:07 -0400
Content-class: urn:content-classes:message
In-Reply-To: <5167D584.7080800@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org



Le 12/04/2013 11:36, Marc Kleine-Budde a =E9crit :
> On 04/11/2013 04:39 PM, Mylene Josserand wrote:
> [...]
>
>> I have read 15 383 frames but after 15 834, it hangs. And after that=
, I
>> can not act on the CAN anymore. A "ifconfig can0 down" hangs the ker=
nel
>> (even with ^C) and I have to restart the board to use the CAN again =
!
>>
>> I really think that it is not linked to your patch (do you want me t=
o
>> send the "Tested by" anyway ?) but to my first problem. The kernel
>
> Can I add your Tested-by to the patch? I hope the patch will go into =
3.9
> release.
>
> Marc
>
Yes no problem !

Do you want me to reply to the patch or just like that is okay ?

--=20
Myl=E8ne JOSSERAND
Navocap
