From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH v12 3/5] dt-bindings: can: tcan4x5x: Add DT bindings for
 TCAN4x5X driver
Date: Thu, 22 Aug 2019 09:20:22 -0500
Message-ID: <ff9e007b-6e39-3d64-b62b-93c281d69113@ti.com>
References: <20190509161109.10499-1-dmurphy@ti.com>
 <20190509161109.10499-3-dmurphy@ti.com>
 <bdf06ead-a2e8-09a9-8cdd-49b54ec9da72@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <bdf06ead-a2e8-09a9-8cdd-49b54ec9da72@pengutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>, wg@grandegger.com, davem@davemloft.net
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Marc

On 8/16/19 4:38 AM, Marc Kleine-Budde wrote:
> On 5/9/19 6:11 PM, Dan Murphy wrote:
>> DT binding documentation for TI TCAN4x5x driver.
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> ---
>>
>> v12 - No changes - https://lore.kernel.org/patchwork/patch/1052300/
>>
>> v11 - No changes - https://lore.kernel.org/patchwork/patch/1051178/
>> v10 - No changes - https://lore.kernel.org/patchwork/patch/1050488/
>> v9 - No Changes - https://lore.kernel.org/patchwork/patch/1050118/
>> v8 - No Changes - https://lore.kernel.org/patchwork/patch/1047981/
>> v7 - Made device state optional - https://lore.kernel.org/patchwork/patch/1047218/
>> v6 - No changes - https://lore.kernel.org/patchwork/patch/1042445/
>>
>>   .../devicetree/bindings/net/can/tcan4x5x.txt  | 37 +++++++++++++++++++
>>   1 file changed, 37 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/net/can/tcan4x5x.txt
>>
>> diff --git a/Documentation/devicetree/bindings/net/can/tcan4x5x.txt b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
>> new file mode 100644
>> index 000000000000..c388f7d9feb1
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
>> @@ -0,0 +1,37 @@
>> +Texas Instruments TCAN4x5x CAN Controller
>> +================================================
>> +
>> +This file provides device node information for the TCAN4x5x interface contains.
>> +
>> +Required properties:
>> +	- compatible: "ti,tcan4x5x"
>> +	- reg: 0
>> +	- #address-cells: 1
>> +	- #size-cells: 0
>> +	- spi-max-frequency: Maximum frequency of the SPI bus the chip can
>> +			     operate at should be less than or equal to 18 MHz.
>> +	- data-ready-gpios: Interrupt GPIO for data and error reporting.
>> +	- device-wake-gpios: Wake up GPIO to wake up the TCAN device.
>> +
>> +See Documentation/devicetree/bindings/net/can/m_can.txt for additional
>> +required property details.
>> +
>> +Optional properties:
>> +	- reset-gpios: Hardwired output GPIO. If not defined then software
>> +		       reset.
>> +	- device-state-gpios: Input GPIO that indicates if the device is in
>> +			      a sleep state or if the device is active.
>> +
>> +Example:
>> +tcan4x5x: tcan4x5x@0 {
>> +		compatible = "ti,tcan4x5x";
>> +		reg = <0>;
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		spi-max-frequency = <10000000>;
>> +		bosch,mram-cfg = <0x0 0 0 32 0 0 1 1>;
>> +		data-ready-gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
> Can you convert this into a proper interrupt property? E.g.:

OK.  Do you want v13 or do you want patches on top for net-next?

Dan


>
>>                  interrupt-parent = <&gpio4>;
>>                  interrupts = <13 0x2>;
> See:
> https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/net/can/microchip,mcp251x.txt#L21
> https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/tree/drivers/net/can/spi/mcp251x.c?h=mcp251x#n945

This second link says it invalid

Dan

>
>> +		device-state-gpios = <&gpio3 21 GPIO_ACTIVE_HIGH>;
>> +		device-wake-gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
>> +		reset-gpios = <&gpio1 27 GPIO_ACTIVE_LOW>;
>> +};
> Marc
>
