From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH v4] can/peak_usb: add support for PEAK new CANFD USB
 adapters
Date: Wed, 14 Jan 2015 11:56:01 +0100
Message-ID: <54B64B41.2040500@peak-system.com>
References: <1420538446-8336-1-git-send-email-s.grosjean@peak-system.com>
 <54AD66C5.10908@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:57924 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980AbbANK4I (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 14 Jan 2015 05:56:08 -0500
In-Reply-To: <54AD66C5.10908@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Oliver Hartkopp <socketcan@hartkopp.net>

Hi again Marc,

Well... What's wrong?

    $ git clone https://gitorious.org/linux-can/linux-can.git
    Cloning into 'linux-can'...
    error: RPC failed; result=3D22, HTTP code =3D 504
    fatal: The remote end hung up unexpectedly

(same with linux-can-next...)

Regards,

St=C3=A9phane

Le 07/01/2015 18:03, Marc Kleine-Budde a =C3=A9crit :
> On 01/06/2015 11:00 AM, Stephane Grosjean wrote:
>> >Add support for the following new PEAK-System technik CANFD USB ada=
pters:
>> >
>> >PCAN-USB FD             single CANFD channel USB adapter
>> >PCAN-USB Pro FD         dual CANFD channels USB adapter
> Can you please work out the correct ISO/non-ISO for CAN-fd with Olive=
r.
> If you need CAN_CTRLMODE_FD_NON_ISO make your patch based on
>
>      https://gitorious.org/linux-can/linux-can.git  testing
>

--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt
Handelsregister Darmstadt HRB 9183=20
Geschaeftsfuehrung: Alexander Gach, Uwe Wilhelm
--
