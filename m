From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v4 1/4] can: m_can: Create a m_can platform framework
Date: Fri, 18 Jan 2019 07:56:24 +0100
Message-ID: <641ae2ce-def9-6032-b8dc-cc71311bc993@grandegger.com>
References: <20190117200601.16416-1-dmurphy@ti.com>
 <aa72c1a7-ee16-dbde-0b75-96f9632ec431@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <aa72c1a7-ee16-dbde-0b75-96f9632ec431@ti.com>
Content-Language: en-GB
Sender: netdev-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>, mkl@pengutronix.de, davem@davemloft.net
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Hello Dan,

Am 17.01.19 um 21:08 schrieb Dan Murphy:
> Wolfgang
> 
> On 1/17/19 2:05 PM, Dan Murphy wrote:
>> Create a m_can platform framework that peripherial
>> devices can register to and use common code and register sets.
>> The peripherial devices may provide read/write and configuration
>> support of the IP.
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> ---
>>  drivers/net/can/m_can/m_can.c          |   6 +
>>  drivers/net/can/m_can/m_can_platform.c | 209 +++++++++++++++++++++++++
>>  drivers/net/can/m_can/m_can_platform.h | 163 +++++++++++++++++++
>>  3 files changed, 378 insertions(+)
>>  create mode 100644 drivers/net/can/m_can/m_can_platform.c
>>  create mode 100644 drivers/net/can/m_can/m_can_platform.h
>>

... snip ...

> This patch set is working for the TCAN and at least boots on io-mapped devices.
> We have a couple of customers who are looking at using this implementation and we would like to
> start moving this patch set along in the review.
> 
> I did not put a change log in here as there have been no comments for the last 3 patch sets I sent.
> 
> This v4 squashes a few bugs I found during testing across all the files.

OK, after a very busy week I will try to find time for the review...
finally.

Thanks,

Wolfgang.
