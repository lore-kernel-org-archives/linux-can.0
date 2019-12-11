From: Sean Nyekjaer <sean@geanix.com>
Subject: Re: [PATCH v3 1/2] can: m_can: tcan4x5x: put the device out of
 standby before register access
Date: Wed, 11 Dec 2019 10:13:07 +0100
Message-ID: <bc0014ec-7302-97f4-5d71-8d029b0fb1fb@geanix.com>
References: <20191211064208.84656-1-sean@geanix.com>
 <8b1682ad-c291-252e-c768-63a7a4801aff@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <8b1682ad-c291-252e-c768-63a7a4801aff@pengutronix.de>
Content-Language: en-US-large
Sender: stable-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>, dmurphy@ti.com, linux-can@vger.kernel.org
Cc: martin@geanix.com, stable@vger.kernel.org
List-Id: linux-can.vger.kernel.org



On 11/12/2019 09.42, Marc Kleine-Budde wrote:
> On 12/11/19 7:42 AM, Sean Nyekjaer wrote:
>> The m_can tries to detect if Non ISO Operation is available while in standby,
>> this function results in the following error:
>>
>> tcan4x5x spi2.0 (unnamed net_device) (uninitialized): Failed to init module
>> tcan4x5x spi2.0: m_can device registered (irq=84, version=32)
>> tcan4x5x spi2.0 can2: TCAN4X5X successfully initialized.
>>
>> When the tcan device comes out of reset it comes out in standby mode.
>> The m_can driver tries to access the control register but fails due to
>> the device is in standby mode.
>> So this patch will put the tcan device in normal mode before the m_can
>> driver does the initialization.
>>
>> Fixes: a229abeed7f7 ("can: tcan4x5x: Turn on the power before parsing the config")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> 
> Applied both to linux-can.
> 

Oh, the commit id for "can: tcan4x5x: Turn on the power before parsing 
the config" have changed, since this morning :)

The new commit is 0d38aa7d1090

Thanks
/Sean
