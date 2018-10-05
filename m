From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 2/2] can: tcan4x5x: Add tcan4x5x driver to the kernel
Date: Fri, 5 Oct 2018 07:56:20 +0200
Message-ID: <6f055cd9-9452-0b4c-2df2-3d0cc06f9e68@grandegger.com>
References: <20180910201241.24092-1-dmurphy@ti.com>
 <20180910201241.24092-2-dmurphy@ti.com>
 <631340c2-78a6-eec3-0ab2-713dddd8e84f@ti.com>
 <45621ef7-bc87-3d1e-efca-e6387fdebf9a@grandegger.com>
 <7a75a096-d07f-693e-74b6-74a76c00acf5@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7a75a096-d07f-693e-74b6-74a76c00acf5@ti.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>, mkl@pengutronix.de, davem@davemloft.net
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Mario.Huettel" <Mario.Huettel@de.bosch.com>
List-Id: linux-can.vger.kernel.org

Hello Dan,

Am 04.10.2018 um 22:26 schrieb Dan Murphy:
> Wolfgang
> 
> On 09/26/2018 12:54 PM, Wolfgang Grandegger wrote:
>> Hello,
>>
>> I wonder why you do not extend the existing MCAN driver by implementing
>> an interface to access the hardware. Would that be feasible?
>>
> 
> I have created a m_can_core code base that can be used by other hardware that
> have special needs.
> 
> So I have created the m_can_core, m_can and the tcan4x5x drivers.

Great, I still think it's a good idea to have just one "m_can" driver.

> I can RFC the code to see if this is what is expected.
> It is not 100% working but it is close enough for a directional call.

That would be nice! Most of the SPI accesses are pure register accesses.
A few read/write more bytes at a time (for data, etc.) but that could be
handled by appropriate interface functions. One general problem is that
SPI accesses are not possible from interrupt context requiring threads
or work queues. Also NAPI is usually not used.

Other opinions?

Wolfgang.

PS: I have added Mario to the CC. Maybe he could test a common driver on
his M_CAN hardware.
