From: Dan Murphy <dmurphy-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2] can: tcan4x5x: Turn on the power before parsing the
 config
Date: Fri, 31 Jan 2020 11:27:44 -0600
Message-ID: <db84cce8-925e-0b31-e196-6543359e6ea5@ti.com>
References: <20191210163204.28225-1-dmurphy@ti.com>
 <4a2e80f0-13c5-df7b-65af-25f86ca48f2a@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4a2e80f0-13c5-df7b-65af-25f86ca48f2a-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-can.vger.kernel.org

Marc

On 1/2/20 6:38 AM, Marc Kleine-Budde wrote:
> On 12/10/19 5:32 PM, Dan Murphy wrote:
>> The parse config function now performs action on the device either
>> reading or writing and a reset.  If the regulator is managed it needs
>> to be turned on.  So turn on the regulator if available if the parsing
>> fails then turn off the regulator.
> Another BTW:
> Consider converting the switching of the vsup to runtime_pm.
>
> Yet another one:
> Why do you disable the clocks in the error path of tcan4x5x_can_probe(),
> but never enable them?
>
>> out_clk:
>> 	if (!IS_ERR(mcan_class->cclk)) {
>> 		clk_disable_unprepare(mcan_class->cclk);
>> 		clk_disable_unprepare(mcan_class->hclk);
>> 	}
> - please move the clock handling from the m_can.c to the individual
>    driver
> - please move the clock handling to runtime_pm in the individual driver
> - remove the obsolete m_can_class_get_clocks()
> - make runtime_pm mandatory
>
> regards,
> Marc
>
I have separate the clock calls into pm runtime calls and moved the 
clock init into the respective children of the framework.

Did you want me to submit 1 patch with all the changes or would you like 
3 separate patches?  First 2 patches will abstract the clocks away into 
the children and the 3rd patch would be to remove the clocks API from 
the framework

Dan
