From: Kalle Valo <kvalo@codeaurora.org>
Subject: Re: [PATCH trivial 2/2] drivers: net: Fix Kconfig indentation
Date: Tue, 24 Sep 2019 08:15:39 +0300
Message-ID: <87sgomi8as.fsf@tynnyri.adurom.net>
References: <20190923155243.6997-1-krzk@kernel.org>
        <20190923155243.6997-2-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190923155243.6997-2-krzk@kernel.org> (Krzysztof Kozlowski's
        message of "Mon, 23 Sep 2019 17:52:43 +0200")
Sender: netdev-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Michael Grzeschik <m.grzeschik@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, Jiri Kosina <trivial@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, linux-rdma@vger.kernel.org, linux-wireless@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, lvs-devel@vger.kernel
List-Id: linux-can.vger.kernel.org

Krzysztof Kozlowski <krzk@kernel.org> writes:

> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
>     $ sed -e 's/^        /\t/' -i */Kconfig
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

[...]

>  drivers/net/wireless/ath/Kconfig              |   2 +-
>  drivers/net/wireless/ath/ar5523/Kconfig       |   4 +-
>  drivers/net/wireless/ath/ath6kl/Kconfig       |   2 +-
>  drivers/net/wireless/ath/ath9k/Kconfig        |   2 +-
>  drivers/net/wireless/ath/carl9170/Kconfig     |   6 +-
>  drivers/net/wireless/atmel/Kconfig            |  32 ++---
>  drivers/net/wireless/intel/ipw2x00/Kconfig    | 116 +++++++++---------
>  drivers/net/wireless/intel/iwlegacy/Kconfig   |   6 +-
>  drivers/net/wireless/intel/iwlwifi/Kconfig    |   6 +-
>  drivers/net/wireless/ralink/rt2x00/Kconfig    |  24 ++--

I hope this goes through net or net-next, less chances of conflits then.

Acked-by: Kalle Valo <kvalo@codeaurora.org>

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
