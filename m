From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] arm64: dts: r8a7795: Add CAN FD support
Date: Wed, 2 Mar 2016 15:03:57 +0300
Message-ID: <56D6D6AD.7080207@cogentembedded.com>
References: <1456826640-23237-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
 <56D59538.2060100@cogentembedded.com>
 <SG2PR06MB1038FBA247777C89F70E2633C3BC0@SG2PR06MB1038.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <SG2PR06MB1038FBA247777C89F70E2633C3BC0@SG2PR06MB1038.apcprd06.prod.outlook.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>, "mkl@pengutronix.de" <mkl@pengutronix.de>, "wg@grandegger.com" <wg@grandegger.com>, "horms@verge.net.au" <horms@verge.net.au>, "magnus.damm@gmail.com" <magnus.damm@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>
Cc: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Chris Paterson <Chris.Paterson2@renesas.com>
List-Id: linux-can.vger.kernel.org

Hello.

On 3/2/2016 10:29 AM, Ramesh Shanmugasundaram wrote:

>>> Adds CAN FD controller node for r8a7795.
>>>
>>> Note: CAN FD controller register base address specified in R-Car Gen3
>>> Hardware User Manual v0.5E is incorrect. The correct address is:
>>>
>>> CAN FD - 0xe66c0000
>>>
>>> Signed-off-by: Ramesh Shanmugasundaram
>>> <ramesh.shanmugasundaram@bp.renesas.com>
>>> ---
>>> Hi All,
>>>
>>>      This patch is based on linux-next (tag:next-20160225) with the
>> following
>>>      patches applied on top.
>>>
>>>      [PATCH v2] arm64: dts: r8a7795: Add CAN external clock support
>>>      [PATCH] arm64: dts: r8a7795: Add CAN support
>>>
>>>      The respective CAN subsystem changes are submitted separately here
>>> (https://www.mail-archive.com/linux-renesas-soc@vger.kernel.org/msg013
>>> 88.html)
>>>
>>> Thanks,
>>> Ramesh
>>> ---
>>>    arch/arm64/boot/dts/renesas/r8a7795.dtsi | 24 ++++++++++++++++++++++++
>>>    1 file changed, 24 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
>>> b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
>>> index a88f8d8..5049ba6 100644
>>> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
>>> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
>>> @@ -553,6 +553,30 @@
>>>    			status = "disabled";
>>>    		};
>>>
>>> +		canfd: canfd@e66c0000 {
>>
>>      The node name should still be "can@e66c0000", I think.
>
> Thanks for the review.
>
> The SoC has CAN controller too

    Yes, I figured. BTW, is the CAN-FD identical to the older CAN on the 
hardware level? I haven't see you posting the CAN-FD driver yet...

> and hence I chose this node name to differentiate. A grep of canfd on sysfs would tell if the controller is enabled. The channels on "net" would still be named "canx".
>
> I'll change it if you still feel "can@e66c0000" is more appropriate.

    It is -- the node names should be generic and ePAPR even has the "can" 
name listed explicitly in the section 2.2.2.

> Thanks,
> Ramesh

MBR, Sergei
