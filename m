From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 2/2] can: tcan4x5x: Add tcan4x5x driver to the kernel
Date: Wed, 26 Sep 2018 20:34:47 +0200
Message-ID: <f7bde33a-894b-9b27-6475-d69aaf19df1a@grandegger.com>
References: <20180910201241.24092-1-dmurphy@ti.com>
 <20180910201241.24092-2-dmurphy@ti.com>
 <631340c2-78a6-eec3-0ab2-713dddd8e84f@ti.com>
 <45621ef7-bc87-3d1e-efca-e6387fdebf9a@grandegger.com>
 <4c9396a4-4028-f013-b22b-a181ef4278c7@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4c9396a4-4028-f013-b22b-a181ef4278c7@ti.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>, mkl@pengutronix.de, davem@davemloft.net
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Hello Dan,

Am 26.09.2018 um 20:00 schrieb Dan Murphy:
> Wolfgang
> 
> On 09/26/2018 12:54 PM, Wolfgang Grandegger wrote:
>> Hello,
>>
>> I wonder why you do not extend the existing MCAN driver by implementing
>> an interface to access the hardware. Would that be feasible?
>>
> 
> That did cross my mind. The issue is I have no way of testing the existing
> driver to make sure I did not break anything.

Yes, I can imagine, but we should try to avoid duplicated code in the
first place. I personally do not have a MCAN device at hand either, but
we should be able to manage that.

> My thought was to create a basic MCAN framework and attach the devices to it.
> So, like in this case, if there is a special way to talk to the device it can 
> be handled in the device driver.

Basically, that's what I have in mind. The "mcan" driver uses it's own
directory with just one file in it. Maybe the idea behind that was to
extend it sooner than later like the "c_can" driver.

> If thats what is needed then I will have to re-write the driver.

Let's have a closer look first. If it's just about accessing one
register at a time, like with memory mapped io, the interface should be
trivial but with SPI we may want to read/write a bulk of data to speed
up the register accesses, use a work queue or thread, etc.

Wolfgang
