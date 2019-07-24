From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH v12 1/5] can: m_can: Create a m_can platform framework
Date: Wed, 24 Jul 2019 10:36:02 -0500
Message-ID: <443fe5e5-5e5c-f669-1f4b-565d9f3dd6c8@ti.com>
References: <20190509161109.10499-1-dmurphy@ti.com>
 <dbb7bdef-820d-5dcc-d7b5-a82bc1b076fb@ti.com>
 <a8e3f2d3-18c3-3bdb-1318-8964afc7e032@ti.com>
 <93530d94-ec65-de82-448e-f2460dd39fb9@ti.com>
 <0f6c41c8-0071-ed3a-9e65-caf02a0fbefe@ti.com>
 <6fa79302-ad32-7f43-f9d5-af70aa789284@ti.com>
 <f236a88a-485c-9002-1e4a-9a5ad0e1c81f@ti.com>
 <437b6371-8488-a0ff-fa68-d1fb5a81bb8b@ti.com>
 <20190724064754.GC22447@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190724064754.GC22447@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Hello

On 7/24/19 1:47 AM, Greg KH wrote:
> On Tue, Jul 23, 2019 at 10:14:14AM -0500, Dan Murphy wrote:
>> Hello
>>
>> On 7/10/19 7:08 AM, Dan Murphy wrote:
>>> Hello
>>>
>>> On 6/17/19 10:09 AM, Dan Murphy wrote:
>>>> Marc
>>>>
>>>> On 6/10/19 11:35 AM, Dan Murphy wrote:
>>>>> Bump
>>>>>
>>>>> On 6/6/19 8:16 AM, Dan Murphy wrote:
>>>>>> Marc
>>>>>>
>>>>>> Bump
>>>>>>
>>>>>> On 5/31/19 6:51 AM, Dan Murphy wrote:
>>>>>>> Marc
>>>>>>>
>>>>>>> On 5/15/19 3:54 PM, Dan Murphy wrote:
>>>>>>>> Marc
>>>>>>>>
>>>>>>>> On 5/9/19 11:11 AM, Dan Murphy wrote:
>>>>>>>>> Create a m_can platform framework that peripheral
>>>>>>>>> devices can register to and use common code and register sets.
>>>>>>>>> The peripheral devices may provide read/write and configuration
>>>>>>>>> support of the IP.
>>>>>>>>>
>>>>>>>>> Acked-by: Wolfgang Grandegger <wg@grandegger.com>
>>>>>>>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>>>>>>>>> ---
>>>>>>>>>
>>>>>>>>> v12 - Update the m_can_read/write functions to
>>>>>>>>> create a backtrace if the callback
>>>>>>>>> pointer is NULL. - https://lore.kernel.org/patchwork/patch/1052302/
>>>>>>>>>
>>>>>>>> Is this able to be merged now?
>>>>>>> ping
>>>> Wondering if there is anything else we need to do?
>>>>
>>>> The part has officially shipped and we had hoped to have driver
>>>> support in Linux as part of the announcement.
>>>>
>>> Is this being sent in a PR for 5.3?
>>>
>>> Dan
>>>
>> Adding Greg to this thread as I have no idea what is going on with this.
> Why me?  What am I supposed to do here?  I see no patches at all to do
> anything with :(

I am not sure who to email. The maintainer seems to be on hiatus or 
super busy with other work.

So I added you to see if you know how to handle this.  Wolfgang Acked it 
but he said Marc needs to pull

it in.  We have quite a few users of this patchset. I have been hosting 
the patchset in a different tree.

These users keep pinging us for upstream status and all we can do is 
point them to the

LKML to show we are continuing to pursue inclusion.

https://lore.kernel.org/patchwork/project/lkml/list/?series=393454

Thanks
Dan


>
> thanks,
>
> greg "not a miracle worker" k-h
