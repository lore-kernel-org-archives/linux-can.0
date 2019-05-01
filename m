From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH v11 1/5] can: m_can: Create a m_can platform framework
Date: Wed, 1 May 2019 09:10:27 -0500
Message-ID: <a8b9fcca-dc35-3ca4-e3eb-109bc534e804@ti.com>
References: <20190319172651.10012-1-dmurphy@ti.com>
 <3ce79402-00f1-d7e6-955e-1ad7eb00d0de@ti.com>
 <c05a6a22-c162-518d-683a-18731bd67e38@grandegger.com>
 <2d594ba8-e4e4-14f9-1eb0-8f753c79eb54@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2d594ba8-e4e4-14f9-1eb0-8f753c79eb54@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>, mkl@pengutronix.de, davem@davemloft.net
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Hello

On 4/18/19 9:36 AM, Dan Murphy wrote:
> Marc
> 
> On 4/2/19 7:17 AM, Wolfgang Grandegger wrote:
>> Hello Dan,
>>
>> Am 02.04.19 um 14:03 schrieb Dan Murphy:
>>> Wolfgang
>>>
>>> On 3/19/19 12:26 PM, Dan Murphy wrote:
>>>> Create a m_can platform framework that peripheral
>>>> devices can register to and use common code and register sets.
>>>> The peripheral devices may provide read/write and configuration
>>>> support of the IP.
>>>>
>>>> Acked-by: Wolfgang Grandegger <wg@grandegger.com>
>>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>>>> ---
>>>>
>>>
>>> Wondering if this will be going into 5.1 PR?
>>
>> it's Marc who is doing the upstreaming ... and maybe a final review as well.
>>
> 
> Can you tell me if this will be taken?

This patchset has gone unresponded to from the maintainers for quite some time.

I have numerous customers using this patchset from my public repo and they want the
driver in the mainline kernel.

Is there any help or anything needed to get this merged for 5.2?

Dan

> 
> Dan
> 
>> Wolfgang.
>>
