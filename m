From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH v5 1/2] can: m_can: add device tree binding documentation
Date: Fri, 25 Jul 2014 19:53:53 +0800
Message-ID: <CAA+hA=QNDGrO679GBi5oR=KnLZbBh9A+A12QfCG-=Ak_D78rAw@mail.gmail.com>
References: <1405503050-16796-1-git-send-email-b29396@freescale.com>
	<53C64E51.9050606@pengutronix.de>
	<20140716104054.GB20184@shlinux1.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43]:42297 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751348AbaGYLxy (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 25 Jul 2014 07:53:54 -0400
In-Reply-To: <20140716104054.GB20184@shlinux1.ap.freescale.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Dong Aisheng <b29396@freescale.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, mark.rutland@arm.com, devicetree@vger.kernel.org, socketcan@hartkopp.net, varkabhadram@gmail.com, linux-can@vger.kernel.org, robh+dt@kernel.org, wg@grandegger.com, grant.likely@linaro.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Ping...

On Wed, Jul 16, 2014 at 6:40 PM, Dong Aisheng <b29396@freescale.com> wrote:
> On Wed, Jul 16, 2014 at 12:05:05PM +0200, Marc Kleine-Budde wrote:
>> On 07/16/2014 11:30 AM, Dong Aisheng wrote:
>> > add M_CAN device tree binding documentation
>> >
>> > Cc: Wolfgang Grandegger <wg@grandegger.com>
>> > Cc: Marc Kleine-Budde <mkl@pengutronix.de>
>> > Cc: Mark Rutland <mark.rutland@arm.com>
>> > Cc: Oliver Hartkopp <socketcan@hartkopp.net>
>> > Cc: Varka Bhadram <varkabhadram@gmail.com>
>> > Signed-off-by: Dong Aisheng <b29396@freescale.com>
>> > ---
>> > Changes since v4:
>> > - change the name of board dtsi to board dts which is more common
>> >
>> > Changes since v3:
>> > - change mram-cfg property name to bosch,mram-cfg
>> > - indent change
>> > ---
>> >  .../devicetree/bindings/net/can/m_can.txt          |   67 ++++++++++++++++++++
>> >  1 files changed, 67 insertions(+), 0 deletions(-)
>> >  create mode 100644 Documentation/devicetree/bindings/net/can/m_can.txt
>>
>> I'll apply this series once we've got an Ack for the DT folks.
>>
>
> Okay, thanks!
>
> Copy Grant, Rob and Mark in case they have comments.
>
> Regards
> Dong Aisheng
>
>> Marc
>>
>> --
>> Pengutronix e.K.                  | Marc Kleine-Budde           |
>> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
>> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
>> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
>>
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
