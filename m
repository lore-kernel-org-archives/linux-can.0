From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH linux-can/testing] can: tcan4x5x: Disable the INH pin
 device-state GPIO is unavailable
Date: Wed, 8 Jan 2020 14:47:42 -0600
Message-ID: <01f16f0f-cfdf-0a3c-48b1-59e0824c83e8@ti.com>
References: <20191212161536.23264-1-dmurphy@ti.com>
 <b0560413-525c-39ba-30ce-816c098e51ab@pengutronix.de>
 <afa5c681-bbd1-a6f6-2b58-4f24c924144e@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <afa5c681-bbd1-a6f6-2b58-4f24c924144e@pengutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, wg@grandegger.com, sriram.dash@samsung.com
List-Id: linux-can.vger.kernel.org

Marc

On 12/29/19 10:05 AM, Marc Kleine-Budde wrote:
> On 12/29/19 4:32 PM, Marc Kleine-Budde wrote:
>> On 12/12/19 5:15 PM, Dan Murphy wrote:
>>>   static int tcan4x5x_parse_config(struct m_can_classdev *cdev)
>>>   {
>>>   	struct tcan4x5x_priv *tcan4x5x = cdev->device_data;
>>> @@ -383,8 +393,10 @@ static int tcan4x5x_parse_config(struct m_can_classdev *cdev)
>>>   	tcan4x5x->device_state_gpio = devm_gpiod_get_optional(cdev->dev,
>>>   							      "device-state",
>>>   							      GPIOD_IN);
>>> -	if (IS_ERR(tcan4x5x->device_state_gpio))
>>> +	if (IS_ERR(tcan4x5x->device_state_gpio)) {
>>>   		tcan4x5x->device_state_gpio = NULL;
>>> +		tcan4x5x_disable_state(cdev);
>>> +	}
>> For some reason, this hunk doesn't apply, due to the additional:
>>
>>>> 	tcan4x5x->power = devm_regulator_get_optional(cdev->dev,
>>>> 						      "vsup");
> ...which was my fault. :) Please have a look at
>
> https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git/log/?h=testing
>
> ...if I've collected every m_can related patch.

Is this still relevant or have you pulled this in?

It looks good to me.

Dan
