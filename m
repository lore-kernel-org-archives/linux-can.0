From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH 2/2] can: tcan4x5x: Add tcan4x5x driver to the kernel
Date: Fri, 5 Oct 2018 06:45:38 -0500
Message-ID: <5e0d5a5b-dfe0-a2b5-8ca2-733579bda216@ti.com>
References: <20180910201241.24092-1-dmurphy@ti.com>
 <20180910201241.24092-2-dmurphy@ti.com>
 <631340c2-78a6-eec3-0ab2-713dddd8e84f@ti.com>
 <45621ef7-bc87-3d1e-efca-e6387fdebf9a@grandegger.com>
 <7a75a096-d07f-693e-74b6-74a76c00acf5@ti.com>
 <6f055cd9-9452-0b4c-2df2-3d0cc06f9e68@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6f055cd9-9452-0b4c-2df2-3d0cc06f9e68@grandegger.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>, mkl@pengutronix.de, davem@davemloft.net
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Mario.Huettel" <Mario.Huettel@de.bosch.com>
List-Id: linux-can.vger.kernel.org

Wolfgang

On 10/05/2018 12:56 AM, Wolfgang Grandegger wrote:
> Hello Dan,
> 
> Am 04.10.2018 um 22:26 schrieb Dan Murphy:
>> Wolfgang
>>
>> On 09/26/2018 12:54 PM, Wolfgang Grandegger wrote:
>>> Hello,
>>>
>>> I wonder why you do not extend the existing MCAN driver by implementing
>>> an interface to access the hardware. Would that be feasible?
>>>
>>
>> I have created a m_can_core code base that can be used by other hardware that
>> have special needs.
>>
>> So I have created the m_can_core, m_can and the tcan4x5x drivers.
> 
> Great, I still think it's a good idea to have just one "m_can" driver.

The m_can and tcan4x5x provide the device level implementations.  The m_can_core
deals specifically with handling of the m_can IP and protocol.

> 
>> I can RFC the code to see if this is what is expected.
>> It is not 100% working but it is close enough for a directional call.
> 
> That would be nice! Most of the SPI accesses are pure register accesses.
> A few read/write more bytes at a time (for data, etc.) but that could be
> handled by appropriate interface functions. One general problem is that
> SPI accesses are not possible from interrupt context requiring threads
> or work queues. Also NAPI is usually not used.
> 
> Other opinions?

agreed. Is there any issue with moving the request_irq to a threaded_irq?
Not sure how that would affect the timing.

> 
> Wolfgang.
> 
> PS: I have added Mario to the CC. Maybe he could test a common driver on
> his M_CAN hardware.
> 

I found that our am5/dra76 EVM also uses this IP stack.  So I am working with
our experts there to test and review the code as well.

Dan

-- 
------------------
Dan Murphy
