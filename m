From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH 2/2] net: m_can: Make wake-up gpio an optional
Date: Thu, 5 Dec 2019 09:01:26 -0600
Message-ID: <76e96337-bbcf-89f1-2f1c-45144c15cb5b@ti.com>
References: <20191204175112.7308-1-dmurphy@ti.com>
 <20191204175112.7308-2-dmurphy@ti.com>
 <b9eaa5c4-13bc-295f-dcbf-d2a846243682@geanix.com>
 <827b022e-9188-7bcf-25e3-3777df3b08a5@ti.com>
 <809b9ff1-88e3-4e46-33e0-856db37898b2@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <809b9ff1-88e3-4e46-33e0-856db37898b2@pengutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>, Sean Nyekjaer <sean@geanix.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Marc

On 12/5/19 8:39 AM, Marc Kleine-Budde wrote:
> On 12/5/19 2:26 PM, Dan Murphy wrote:
>> On 12/5/19 1:39 AM, Sean Nyekjaer wrote:
>>>
>>> On 04/12/2019 18.51, Dan Murphy wrote:
>>>> The device has the ability to disable the wake-up pin option.
>>>> The wake-up pin can be either force to GND or Vsup and does not have to
>>>> be tied to a GPIO.  In order for the device to not use the wake-up
>>>> feature
>>>> write the register to disable the WAKE_CONFIG option.
>>>>
>>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>>>> CC: Sean Nyekjaer <sean@geanix.com>
>>> Reviewed-by: Sean Nyekjaer <sean@geanix.com>
>>>> ---
>>>
>>> Hi Dan,
>>>
>>> I would add tcan4x5x to the subject of this patch ->
>>> "net: m_can: tcan4x5x Make wake-up gpio an optional"
>>>
>> Do you want me to submit v2 with the $subject change?
>>
>> Or would you fix it up when committing it?
> I'll change the subject while applying.
>
> Dan, what about maintainerchip of the tcan4x5?

Ooops that was buried in my inbox.

It only makes sense for someone from TI to take maintainership of the 
TCAN device.

Do I need to submit a patch to the maintainers file or is the authorship 
enough?

As far as a device what country do you reside in?

Dan


> regards,
> Marc
>
