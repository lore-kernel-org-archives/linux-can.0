From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [RFC PATCH 1/3] can: m_can: Create m_can core to leverage common
 code
Date: Fri, 11 Jan 2019 09:27:12 +0100
Message-ID: <ed8717c2-5de3-a9f5-57c4-093496a0d5f1@grandegger.com>
References: <20181010142055.25271-1-dmurphy@ti.com>
 <20181010142055.25271-2-dmurphy@ti.com>
 <52811b27-00c0-f5e2-2b18-608ccf846723@grandegger.com>
 <349ef8be-f4c7-25cc-2c33-7ce1fd0b0f40@ti.com>
 <9003a544-83cf-7dce-7f14-4abd292d470e@grandegger.com>
 <b73e200c-8a6b-00e0-dabc-af3245cc36fd@ti.com>
 <69d3a046-2d55-06e0-fba7-c9a0d20e6daa@grandegger.com>
 <06e0146a-5f96-5f60-1ab3-be21b854932a@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <06e0146a-5f96-5f60-1ab3-be21b854932a@ti.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>, mkl@pengutronix.de, davem@davemloft.net
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Hello Dan,

Am 10.01.19 um 13:53 schrieb Dan Murphy:
> Wolfgang
> 
> On 1/10/19 1:44 AM, Wolfgang Grandegger wrote:
>> Hello Dan,
>>
>> sorry for my late response on that topic...
>>
>> Am 09.01.19 um 21:58 schrieb Dan Murphy:
>>> Wolfgang
>>>
>>> On 11/3/18 5:45 AM, Wolfgang Grandegger wrote:
>>>> Hello Dan,
>>>>
>>>> Am 31.10.2018 um 21:15 schrieb Dan Murphy:
>>>>> Wolfgang
>>>>>
>>>>> Thanks for the review
>>>>>
>>>>> On 10/27/2018 09:19 AM, Wolfgang Grandegger wrote:
>>>>>> Hello Dan,
>>>>>>
>>>>>> for the RFC, could you please just do the necessary changes to the
>>>>>> existing code. We can discuss about better names, etc. later. For
>>>>>> the review if the common code I quickly did:
>>>>>>
>>>>>>   mv m_can.c m_can_platform.c
>>>>>>   mv m_can_core.c m_can.c
>>>>>>
>>>>>> The file names are similar to what we have for the C_CAN driver.
>>>>>>
>>>>>>   s/classdev/priv/
>>>>>>   variable name s/m_can_dev/priv/
>>>>>>
>>>>>> Then your patch 1/3 looks as shown below. I'm going to comment on that
>>>>>> one. The comments start with "***"....
>>>>>>
>>>>>
>>>>> So you would like me to align the names with the c_can driver?
>>>>
>>>> That would be the obvious choice.
>>>>> <snip>
>>>>>>
>>>>>> *** I didn't review the rest of the patch for now.
>>>>>>
>>>>>
>>>>> snipped the code to reply to the comment.
>>>>>
>>>>>> Looking to the generic code, you didn't really change the way
>>>>>> the driver is accessing the registers. Also the interrupt handling
>>>>>> and rx polling is as it was before. Does that work properly using
>>>>>> the SPI interface of the TCAN4x5x?
>>>>>
>>>>> I don't want to change any of that yet.  Maybe my cover letter was not clear
>>>>> or did not go through.
>>>>>
>>>>> But the intention was just to break out the functionality to create a MCAN framework
>>>>> that can be used by devices that contain the Bosch MCAN core and provider their own protocal to access
>>>>> the registers in the device.
>>>>>
>>>>> I don't want to do any functional changes at this time on the IP code itself until we have a framework.
>>>>> There should be no regression in the io mapped code.
>>>>>
>>>>> I did comment on the interrupt handling and asked if a threaded work queue would affect CAN timing.
>>>>> For the original TCAN driver this was the way it was implemented.
>>>>
>>>> Do threaded interrupts with RX polling make sense? I think we need a
>>>> common interface allowing to select hard-irqs+napi or threaded-irqs.
>>>>
>>>
>>> I have been working on this code for about a month now and I am *not happy* with the amount of change that needs
>>> to be done to make the m_can a framework.
>>>
>>> I can tx/rx frames from another CAN device to the TCAN part but I have not even touched the iomapped code.
>>>
>>> The challenging part is that the m_can code that is currently available does not have to worry about atomic context because
>>> there is no peripheral waiting.  Since the TCAN is a peripheral device we need to take into about the hard waits in IRQ context
>>> as well as the atomic context.  Doing this creates many deltas in the base code that may break iomapped devices.  I have had to 
>>> add the thread_irqs and now I am in the midst of the issue you brought up with napi.  I would have to schedule a queue for perp devices
>>> and leave the non-threaded iomapped irq.
>>>
>>> At this point I think it may be wise to leave the m_can code alone as it is working and stable and just work on the TCAN driver as
>>> a standalone driver.  A framework would be nice but I think it would destablize the m_can driver which is embedded in many SoC's and
>>> we cannot possibly test everyone of them.
>>
>> Unfortunately, I do not have m_can hardware at hand.
>>
>>> What are your thoughts?
>>
>> What we need is a common set of functions doing tx, rx, error and state
>> handling. This will requires substantial changes to the existing
>> io-mapped m_can driver, of course. I still believe it's worth the
>> effort, but I agree that it's difficult for you to re-write and test the
>> existing m_can driver.
> 
> OK I will keep working on it.  What you are describing is what I have done.
> I have abstracted the register reads and writes away and I am in the process
> of abstracting away the device specific initialization.

Would be nice if you could show your current implementation...

>>
>> What about implementing such a set of common functions plus the SPI
>> specific part for your TCAN device. What do you/others think?
> 
> As stated above this is what I have.  But the m_can driver was written for io-mapped that has no delays
> so we need to take into about peripheral wait time in IRQ and atomic context.
> 
> This is where the issues are stemming from mainly in the atomic context.

... to understand a bit better what you exactly mean. Or does the last
patch you sent already highlight them.

Wolfgang.
