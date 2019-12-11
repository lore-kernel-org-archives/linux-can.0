From: Sean Nyekjaer <sean@geanix.com>
Subject: Re: [PATCH v3 1/2] can: m_can: tcan4x5x: put the device out of
 standby before register access
Date: Wed, 11 Dec 2019 13:15:45 +0100
Message-ID: <56a20412-088c-de3e-0238-9648ed2a44c7@geanix.com>
References: <20191211064208.84656-1-sean@geanix.com>
 <8b1682ad-c291-252e-c768-63a7a4801aff@pengutronix.de>
 <bc0014ec-7302-97f4-5d71-8d029b0fb1fb@geanix.com>
 <41d13619-fab8-ca19-c340-c80cd80d117e@pengutronix.de>
 <ae996f9a-e50d-8f31-7457-c7fb461f5c9e@geanix.com>
 <614104a2-b667-62aa-4e1d-abcef89a257e@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <614104a2-b667-62aa-4e1d-abcef89a257e@pengutronix.de>
Content-Language: en-US-large
Sender: stable-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>, dmurphy@ti.com, linux-can@vger.kernel.org
Cc: martin@geanix.com, stable@vger.kernel.org
List-Id: linux-can.vger.kernel.org



On 11/12/2019 13.10, Marc Kleine-Budde wrote:
> On 12/11/19 12:28 PM, Sean Nyekjaer wrote:
>> On 11/12/2019 10.44, Marc Kleine-Budde wrote:
>>> On 12/11/19 10:13 AM, Sean Nyekjaer wrote:
>>>>>> When the tcan device comes out of reset it comes out in standby mode.
>>>>>> The m_can driver tries to access the control register but fails due to
>>>>>> the device is in standby mode.
>>>>>> So this patch will put the tcan device in normal mode before the m_can
>>>>>> driver does the initialization.
>>>>>>
>>>>>> Fixes: a229abeed7f7 ("can: tcan4x5x: Turn on the power before parsing the config")
>>>>>> Cc: stable@vger.kernel.org
>>>>>> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
>>>>>
>>>>> Applied both to linux-can.
>>>>
>>>> Oh, the commit id for "can: tcan4x5x: Turn on the power before parsing
>>>> the config" have changed, since this morning :)
>>>
>>> Ahh, I see.
>>>
>>> Until there is a pull request (including a tag) the testing branch is
>>> subject to rebase. Meaning, when there is a patch, that needs update I'm
>>> happy to squash things into it.
>>>
>>> I'm squashing there two commits into one:
>>
>> It's two different authors :-)
> 
> No problem with me. I don't want to have a known broken patch in one
> pull request that gets fixed by another patch in that pull request.

No problem with me, either.
But it's not exactly the same problem they are fixing. They can exist 
separately.

Just do a you find best...

/Sean
