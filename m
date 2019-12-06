From: Sean Nyekjaer <sean@geanix.com>
Subject: Re: [PATCH 1/2] dt-bindings: tcan4x5x: Make wake-gpio an optional
 gpio
Date: Fri, 6 Dec 2019 14:49:52 +0100
Message-ID: <bd4586d0-4ea7-e247-d72d-a759c99860b0@geanix.com>
References: <20191204175112.7308-1-dmurphy@ti.com>
 <d34673db-cc43-6e1d-6f4a-07b25c2c8f7b@geanix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d34673db-cc43-6e1d-6f4a-07b25c2c8f7b@geanix.com>
Content-Language: en-US-large
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>, mkl@pengutronix.de
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
List-Id: linux-can.vger.kernel.org



On 05/12/2019 08.36, Sean Nyekjaer wrote:
> 
> 
> On 04/12/2019 18.51, Dan Murphy wrote:
>> The wake-up of the device can be configured as an optional
>> feature of the device.  Move the wake-up gpio from a requried
>> property to an optional property.
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> CC: Rob Herring <robh@kernel.org>
> Reviewed-by: Sean Nyekjaer <sean@geanix.com>
Tested-by: Sean Nyekjaer <sean@geanix.com>
>> ---
>>   Documentation/devicetree/bindings/net/can/tcan4x5x.txt | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/net/can/tcan4x5x.txt 
>> b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
>> index 27e1b4cebfbd..7cf5ef7acba4 100644
>> --- a/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
>> +++ b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
>> @@ -10,7 +10,6 @@ Required properties:
>>       - #size-cells: 0
>>       - spi-max-frequency: Maximum frequency of the SPI bus the chip can
>>                    operate at should be less than or equal to 18 MHz.
>> -    - device-wake-gpios: Wake up GPIO to wake up the TCAN device.
>>       - interrupt-parent: the phandle to the interrupt controller 
>> which provides
>>                       the interrupt.
>>       - interrupts: interrupt specification for data-ready.
>> @@ -23,6 +22,7 @@ Optional properties:
>>                  reset.
>>       - device-state-gpios: Input GPIO that indicates if the device is in
>>                     a sleep state or if the device is active.
>> +    - device-wake-gpios: Wake up GPIO to wake up the TCAN device.
>>   Example:
>>   tcan4x5x: tcan4x5x@0 {
>>
