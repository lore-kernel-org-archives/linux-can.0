From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 2/4] can: bcm: check timer values before ktime conversion
Date: Thu, 24 Jan 2019 10:13:37 +0100
Message-ID: <4dba8f40-3c51-66de-46c9-d4de660d690e@hartkopp.net>
References: <20190122132116.7074-3-mkl@pengutronix.de>
 <20190123225748.AF445218A1@mail.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190123225748.AF445218A1@mail.kernel.org>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Sasha Levin <sashal@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Hi Shasha,

On 23.01.19 23:57, Sasha Levin wrote:
> Hi,
> 
> [This is an automated email]
> 
> This commit has been processed because it contains a -stable tag.
> The stable tag indicates that it's relevant for the following trees: 2.6.26+
> 
> The bot has tested the following trees: v4.20.3, v4.19.16, v4.14.94, v4.9.151, v4.4.171, v3.18.132.
> 
> v4.20.3: Build OK!
> v4.19.16: Build OK!
> v4.14.94: Build OK!
> v4.9.151: Build OK!
> v4.4.171: Failed to apply! Possible dependencies:
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

As we do have a proper upstream commit hash now ...

https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git/commit/?h=testing&id=93171ba6f1deffd82f381d36cb13177872d023f6

... here is the ported patch for kernels pre version 4.8:

https://marc.info/?l=linux-can&m=154832094402622&w=2

Thanks,
Oliver

ps. the pull request to Dave is still hanging here:

https://marc.info/?l=linux-can&m=154831478900596&w=2
