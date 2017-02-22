From: =?UTF-8?Q?Janusz_U=c5=bcycki?= <j.uzycki@elpromaelectronics.com>
Subject: Re: bug in DT docs vs mcp251x.c driver
Date: Wed, 22 Feb 2017 08:58:43 +0100
Message-ID: <d56accc5-67a8-e474-f1df-f23d4d02d50b@elpromaelectronics.com>
References: <1d36bb5b-b46a-8e9a-672b-907cac5c5ab4@elpromaelectronics.com>
 <CAOMZO5BCcQYNr6qV0qhmRGTBm030kNWyErO66_HOD0A5huYM3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from cloudserver032797.home.net.pl ([89.161.177.31]:58459 "EHLO
        cloudserver032797.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753309AbdBVH6r (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 22 Feb 2017 02:58:47 -0500
In-Reply-To: <CAOMZO5BCcQYNr6qV0qhmRGTBm030kNWyErO66_HOD0A5huYM3A@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: Alexander Shiyan <shc_work@mail.ru>, Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "l.dalek elpromaelectronics.com" <l.dalek@elpromaelectronics.com>

Hi Fabio.

You are right. Thanks.
According to the source code printf adds the "-supply" indeed.
I've not verified the code as I got a report for 3.14 that the driver
does not work with vdd-supply in DT, works with vdd property
and the supply was verified electrically.
Now I have to investigate the problem better.

best regards

Janusz


W dniu 2017-02-21 o 19:47, Fabio Estevam pisze:
> Hi Janusz,
>
> On Tue, Feb 21, 2017 at 3:08 PM, Janusz Użycki
> <j.uzycki@elpromaelectronics.com> wrote:
>> Hi,
>>
>> We've noticed the inconsistency in DT which still exist in kernel v4.10:
>>
>> devm_regulator_get(&spi->dev, "vdd") in drivers/net/can/mcp251x.c
>>
>> vs vdd-supply: Regulator that powers the CAN controller. in
>> bindings/net/can/microchip,mcp251x.txt
> This is correct.
>
> When the regulator is retrieved as devm_regulator_get(dev, "xyz") then
> it searches for a xyz-supply in the dts.

