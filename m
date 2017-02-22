From: =?UTF-8?Q?Janusz_U=c5=bcycki?= <j.uzycki-cjVIcFy54eMe9JSWTWOYM+658FiBabzs@public.gmane.org>
Subject: Re: bug in DT docs vs mcp251x.c driver
Date: Wed, 22 Feb 2017 09:00:06 +0100
Message-ID: <2858a28c-4502-3779-f518-f499770bab28@elpromaelectronics.com>
References: <1d36bb5b-b46a-8e9a-672b-907cac5c5ab4@elpromaelectronics.com>
 <1487742799.631389473@f418.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1487742799.631389473-OruIP1U3PUxsdVUOrk1QfQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Cc: Oliver Hartkopp <socketcan-fJ+pQTUTwRTk1uMJSBkQmQ@public.gmane.org>, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "l.dalek elpromaelectronics.com" <l.dalek-cjVIcFy54eMe9JSWTWOYM+658FiBabzs@public.gmane.org>
List-Id: linux-can.vger.kernel.org

Hi Alexander.

You are right.
According to the source code printf adds the "-supply" indeed.
I've not verified the code as I got a report for 3.14 that the driver
does not work with vdd-supply in DT, works with vdd property
and the supply was verified electrically.
Now I have to investigate the problem better.

best regards

Janusz


W dniu 2017-02-22 o 06:53, Alexander Shiyan pisze:
>> Вторник, 21 февраля 2017, 21:08 +03:00 от Janusz Użycki <j.uzycki-cjVIcFy54eMe9JSWTWOYM+658FiBabzs@public.gmane.org>:
>> We've noticed the inconsistency in DT which still exist in kernel v4.10:
>>
>> devm_regulator_get(&spi->dev, "vdd") in drivers/net/can/mcp251x.c
>>
>> vs vdd-supply: Regulator that powers the CAN controller. in
>> bindings/net/can/microchip,mcp251x.txt
> I do not see the bug here, could you clarify?
>
> ---

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
