From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH v11 1/5] can: m_can: Create a m_can platform framework
Date: Wed, 10 Apr 2019 08:24:09 -0500
Message-ID: <9f33353d-c82f-a117-17de-9b57693bef27@ti.com>
References: <20190319172651.10012-1-dmurphy@ti.com>
 <3ce79402-00f1-d7e6-955e-1ad7eb00d0de@ti.com>
 <c05a6a22-c162-518d-683a-18731bd67e38@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <c05a6a22-c162-518d-683a-18731bd67e38@grandegger.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>, mkl@pengutronix.de, davem@davemloft.net
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Marc

On 4/2/19 7:17 AM, Wolfgang Grandegger wrote:
> Hello Dan,
>
> Am 02.04.19 um 14:03 schrieb Dan Murphy:
>> Wolfgang
>>
>> On 3/19/19 12:26 PM, Dan Murphy wrote:
>>> Create a m_can platform framework that peripheral
>>> devices can register to and use common code and register sets.
>>> The peripheral devices may provide read/write and configuration
>>> support of the IP.
>>>
>>> Acked-by: Wolfgang Grandegger <wg@grandegger.com>
>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>>> ---
>>>
>> Wondering if this will be going into 5.1 PR?
> it's Marc who is doing the upstreaming ... and maybe a final review as well.

Don't know if the original message went through.

But wondering if this will make it into v5.2

Dan

> Wolfgang.
