From: Sean Nyekjaer <sean@geanix.com>
Subject: Re: [PATCH v2 1/2] can: m_can: tcan4x5x: put the device out of
 standby before register access
Date: Thu, 2 Jan 2020 17:09:31 +0100
Message-ID: <973df29f-c930-c6b2-17c4-3e3b468f3bf0@geanix.com>
References: <20191209192440.998659-1-sean@geanix.com>
 <d58b9d08-dbd8-b73e-dae1-286c1a3ce8f2@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <d58b9d08-dbd8-b73e-dae1-286c1a3ce8f2@pengutronix.de>
Content-Language: en-US-large
Sender: stable-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: dmurphy@ti.com, martin@geanix.com, stable@vger.kernel.org
List-Id: linux-can.vger.kernel.org



On 02/01/2020 16.46, Marc Kleine-Budde wrote:
> On 12/9/19 8:24 PM, Sean Nyekjaer wrote:
>> The m_can tries to detect of niso (canfd) is available while in standby,
>> this function results in the following error:
>>
>> tcan4x5x spi2.0 (unnamed net_device) (uninitialized): Failed to init module
>> tcan4x5x spi2.0: m_can device registered (irq=84, version=32)
>> tcan4x5x spi2.0 can2: TCAN4X5X successfully initialized.
> 
> Can you add the missing error handling to m_can_config_endisable(), and
> handle this error correctly in all its callers?
> 
> Marc
> 

Hi Marc

Sorry if this was a bit of mess :)
Version 6 of this patch is already applied....
https://www.spinics.net/lists/linux-can/msg03186.html

Do you want me to add more error handling than this?

/Sean
