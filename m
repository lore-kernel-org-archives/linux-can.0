From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v2] can: bcm: check timer values before ktime conversion
Date: Wed, 16 Jan 2019 16:05:19 +0100
Message-ID: <a0bd40cb-3668-6407-85b3-902fab13c8df@hartkopp.net>
References: <20190113183143.10612-1-socketcan@hartkopp.net>
 <20190116133603.25A5A20873@mail.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190116133603.25A5A20873@mail.kernel.org>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Sasha Levin <sashal@kernel.org>, davem@davemloft.net, netdev@vger.kernel.org
Cc: linux-can@vger.kernel.org, lifeasageek@gmail.com, stable@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Hi Sasha,

On 1/16/19 2:36 PM, Sasha Levin wrote:
> Hi,
> 
> [This is an automated email]
> 
> This commit has been processed because it contains a -stable tag.
> The stable tag indicates that it's relevant for the following trees: 2.6.26+
> 
> The bot has tested the following trees: v4.20.2, v4.19.15, v4.14.93, v4.9.150, v4.4.170, v3.18.132.
> 
> v4.20.2: Build OK!
> v4.19.15: Build OK!
> v4.14.93: Build OK!
> v4.9.150: Build OK!
> v4.4.170: Failed to apply! Possible dependencies:
>      2b5f5f5dc114 ("can: bcm: unify bcm_msg_head handling and prepare function parameters")
>      6f3b911d5f29 ("can: bcm: add support for CAN FD frames")
>      72c8a89ad2e4 ("can: bcm: use CAN frame instead of can_frame in comments")
>      95acb490ec51 ("can: bcm: fix indention and other minor style issues")
> 
> v3.18.132: Failed to apply! Possible dependencies:
>      069f8457ae52 ("can: fix spelling errors")
>      2b5f5f5dc114 ("can: bcm: unify bcm_msg_head handling and prepare function parameters")
>      6ce8e9ce5989 ("new helper: memcpy_from_msg()")
>      6f3b911d5f29 ("can: bcm: add support for CAN FD frames")
>      72c8a89ad2e4 ("can: bcm: use CAN frame instead of can_frame in comments")
>      95acb490ec51 ("can: bcm: fix indention and other minor style issues")
>      ba61a8d9d780 ("can: avoid using timeval for uapi")
> 
> 
> How should we proceed with this patch?

Applying the patch on e.g. 3.2.102 also leads to

patching file net/can/bcm.c
Hunk #1 FAILED at 67.
Hunk #2 FAILED at 140.
Hunk #3 succeeded at 847 with fuzz 2 (offset -26 lines).
Hunk #4 succeeded at 1018 with fuzz 2 (offset -39 lines).
2 out of 4 hunks FAILED -- saving rejects to file net/can/bcm.c.rej

The first two hunks just adding a define and and function *somewhere* at 
the top of the C file.

I can provide patches for the requested stable kernels once we have a 
reference for the upstream commit hash.

Would that be ok for you?

Best regards,
Oliver
