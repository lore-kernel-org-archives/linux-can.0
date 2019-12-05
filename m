From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH 2/2] net: m_can: Make wake-up gpio an optional
Date: Thu, 5 Dec 2019 07:26:05 -0600
Message-ID: <827b022e-9188-7bcf-25e3-3777df3b08a5@ti.com>
References: <20191204175112.7308-1-dmurphy@ti.com>
 <20191204175112.7308-2-dmurphy@ti.com>
 <b9eaa5c4-13bc-295f-dcbf-d2a846243682@geanix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b9eaa5c4-13bc-295f-dcbf-d2a846243682@geanix.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sean Nyekjaer <sean@geanix.com>, mkl@pengutronix.de
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Marc

On 12/5/19 1:39 AM, Sean Nyekjaer wrote:
>
>
> On 04/12/2019 18.51, Dan Murphy wrote:
>> The device has the ability to disable the wake-up pin option.
>> The wake-up pin can be either force to GND or Vsup and does not have to
>> be tied to a GPIO.  In order for the device to not use the wake-up 
>> feature
>> write the register to disable the WAKE_CONFIG option.
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> CC: Sean Nyekjaer <sean@geanix.com>
> Reviewed-by: Sean Nyekjaer <sean@geanix.com>
>> ---
>
>
> Hi Dan,
>
> I would add tcan4x5x to the subject of this patch ->
> "net: m_can: tcan4x5x Make wake-up gpio an optional"
>
Do you want me to submit v2 with the $subject change?

Or would you fix it up when committing it?

Dan
