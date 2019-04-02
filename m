From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v11 1/5] can: m_can: Create a m_can platform framework
Date: Tue, 2 Apr 2019 14:17:55 +0200
Message-ID: <c05a6a22-c162-518d-683a-18731bd67e38@grandegger.com>
References: <20190319172651.10012-1-dmurphy@ti.com>
 <3ce79402-00f1-d7e6-955e-1ad7eb00d0de@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <3ce79402-00f1-d7e6-955e-1ad7eb00d0de@ti.com>
Content-Language: en-GB
Sender: netdev-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>, mkl@pengutronix.de, davem@davemloft.net
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Hello Dan,

Am 02.04.19 um 14:03 schrieb Dan Murphy:
> Wolfgang
> 
> On 3/19/19 12:26 PM, Dan Murphy wrote:
>> Create a m_can platform framework that peripheral
>> devices can register to and use common code and register sets.
>> The peripheral devices may provide read/write and configuration
>> support of the IP.
>>
>> Acked-by: Wolfgang Grandegger <wg@grandegger.com>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> ---
>>
> 
> Wondering if this will be going into 5.1 PR?

it's Marc who is doing the upstreaming ... and maybe a final review as well.

Wolfgang.
