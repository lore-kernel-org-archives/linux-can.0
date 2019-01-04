From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v3] can: gw: ensure DLC boundaries after CAN frame
 modification
Date: Fri, 04 Jan 2019 13:41:26 -0800 (PST)
Message-ID: <20190104.134126.1987487762349795104.davem@davemloft.net>
References: <20190104145526.28492-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190104145526.28492-1-mkl@pengutronix.de>
Sender: stable-owner@vger.kernel.org
To: mkl@pengutronix.de
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de, netdev@vger.kernel.org, socketcan@hartkopp.net, ieatmuttonchuan@gmail.com, meissner@suse.de, mkubecek@suse.cz, stable@vger.kernel.org
List-Id: linux-can.vger.kernel.org

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri,  4 Jan 2019 15:55:26 +0100

> From: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> Muyu Yu provided a POC where user root with CAP_NET_ADMIN can create a CAN
> frame modification rule that makes the data length code a higher value than
> the available CAN frame data size. In combination with a configured checksum
> calculation where the result is stored relatively to the end of the data
> (e.g. cgw_csum_xor_rel) the tail of the skb (e.g. frag_list pointer in
> skb_shared_info) can be rewritten which finally can cause a system crash.
> 
> Michael Kubecek suggested to drop frames that have a DLC exceeding the
> available space after the modification process and provided a patch that can
> handle CAN FD frames too. Within this patch we also limit the length for the
> checksum calculations to the maximum of Classic CAN data length (8).
> 
> CAN frames that are dropped by these additional checks are counted with the
> CGW_DELETED counter which indicates misconfigurations in can-gw rules.
> 
> This fixes CVE-2019-3701.
> 
> Reported-by: Muyu Yu <ieatmuttonchuan@gmail.com>
> Reported-by: Marcus Meissner <meissner@suse.de>
> Suggested-by: Michal Kubecek <mkubecek@suse.cz>
> Tested-by: Muyu Yu <ieatmuttonchuan@gmail.com>
> Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Cc: linux-stable <stable@vger.kernel.org> # >= v3.2
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Marc, do you want me to apply this directly to my net tree?

Thanks.
