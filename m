From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH v2] can: tcan4x5x: Turn on the power before parsing the
 config
Date: Fri, 24 Jan 2020 13:50:01 -0600
Message-ID: <3a67743b-aec6-ba4e-14a6-c2ab327e1eae@ti.com>
References: <20191210163204.28225-1-dmurphy@ti.com>
 <4a2e80f0-13c5-df7b-65af-25f86ca48f2a@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4a2e80f0-13c5-df7b-65af-25f86ca48f2a@pengutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
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

Ack to the above I have made these changes locally.  Will submit next week.

Dan


> regards,
> Marc
>
