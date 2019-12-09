From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH] can: tcan4x5x: Turn on the power before parsing the
 config
Date: Mon, 9 Dec 2019 15:44:09 -0600
Message-ID: <4ae989d0-dfa9-1b0c-0f3a-0a338605c3f1@ti.com>
References: <20191209212351.27518-1-dmurphy@ti.com>
 <deabf78f-5b6a-f631-412d-49dd6f0c372a@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <deabf78f-5b6a-f631-412d-49dd6f0c372a@pengutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Marc

On 12/9/19 3:38 PM, Marc Kleine-Budde wrote:
> On 12/9/19 10:23 PM, Dan Murphy wrote:
>> The parse config function now performs action on the device either
>> reading or writing and a reset.  If the regulator is managed it needs
>> to be turned on.  So turn on the regulator if available if the parsing
>> fails then turn off the regulator.
>>
>> Fixes: a5235f3c7c23 ("can: tcan45x: Make wake-up GPIO an optional GPIO")
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> ---
>>   drivers/net/can/m_can/tcan4x5x.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
>> index 4e1789ea2bc3..515486fcb150 100644
>> --- a/drivers/net/can/m_can/tcan4x5x.c
>> +++ b/drivers/net/can/m_can/tcan4x5x.c
>> @@ -451,11 +451,11 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
>>   	priv->regmap = devm_regmap_init(&spi->dev, &tcan4x5x_bus,
>>   					&spi->dev, &tcan4x5x_regmap);
>>   
>> +	tcan4x5x_power_enable(priv->power, 1);
> please add error handling

Ack


> Marc
>
