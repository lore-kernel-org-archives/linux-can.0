From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH v12 3/5] dt-bindings: can: tcan4x5x: Add DT bindings for
 TCAN4x5X driver
Date: Thu, 22 Aug 2019 10:58:50 -0500
Message-ID: <d7c7dba5-9d7a-07c8-a0b9-fe3ca1ddd4c3@ti.com>
References: <20190509161109.10499-1-dmurphy@ti.com>
 <20190509161109.10499-3-dmurphy@ti.com>
 <bdf06ead-a2e8-09a9-8cdd-49b54ec9da72@pengutronix.de>
 <ff9e007b-6e39-3d64-b62b-93c281d69113@ti.com>
 <6c2bf55f-e360-c51a-e7bb-effc86aa5b6c@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6c2bf55f-e360-c51a-e7bb-effc86aa5b6c@pengutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>, wg@grandegger.com, davem@davemloft.net
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Marc

On 8/22/19 10:46 AM, Marc Kleine-Budde wrote:
> On 8/22/19 4:20 PM, Dan Murphy wrote:
>>>> +tcan4x5x: tcan4x5x@0 {
>>>> +		compatible = "ti,tcan4x5x";
>>>> +		reg = <0>;
>>>> +		#address-cells = <1>;
>>>> +		#size-cells = <1>;
>>>> +		spi-max-frequency = <10000000>;
>>>> +		bosch,mram-cfg = <0x0 0 0 32 0 0 1 1>;
>>>> +		data-ready-gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
>>> Can you convert this into a proper interrupt property? E.g.:
>> OK.  Do you want v13 or do you want patches on top for net-next?
> Please use net-next/master as the base.


Thanks for the reply.  I see that that there are patches on top of the 
driver so I will send patches on top of that.

Dan

<snip>
