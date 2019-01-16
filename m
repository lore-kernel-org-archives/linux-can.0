From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v2] can: bcm: check timer values before ktime conversion
Date: Wed, 16 Jan 2019 16:54:25 +0100
Message-ID: <922cc9ad-4c62-8b52-b3a2-06c262d4e6dd@hartkopp.net>
References: <20190113183143.10612-1-socketcan@hartkopp.net>
 <20190116133603.25A5A20873@mail.kernel.org>
 <a0bd40cb-3668-6407-85b3-902fab13c8df@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <a0bd40cb-3668-6407-85b3-902fab13c8df@hartkopp.net>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Sasha Levin <sashal@kernel.org>, davem@davemloft.net, netdev@vger.kernel.org
Cc: linux-can@vger.kernel.org, lifeasageek@gmail.com, stable@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Hi Sasha,

some more details ...

> On 1/16/19 2:36 PM, Sasha Levin wrote:

>> This commit has been processed because it contains a -stable tag.
>> The stable tag indicates that it's relevant for the following trees: 
>> 2.6.26+
>>

>> v4.9.150: Build OK!
>> v4.4.170: Failed to apply! Possible dependencies:

This patch introduced in 4.8 leads to the problem:
>>      6f3b911d5f29 ("can: bcm: add support for CAN FD frames")

I will provide a patch which applies to all Linux pre-4.8 kernels once 
we have an upstream commit hash.

Best regards,
Oliver
