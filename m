Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C337C3F1ABD
	for <linux-can@vger.kernel.org>; Fri, 24 Jul 2026 09:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784884100; cv=none; b=p+0FDD/Sjyhg1ckGYVKMIPIz9i91KeKc1F395czH5FQpAZb82oAPHi2gyuDvjBz1RjEArcOmx2pK0UzyZoZHe0H+xZWZ6jKoJSTPD9s3f2VFDycCjNWcjFNlGtYz6SzxZjSbiI1HEjNWmWeFjMSE2rTSoBzygOjlr80osU/iolM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784884100; c=relaxed/simple;
	bh=HghB87T9wuVK0V8ssQsbWKMB0URUxQqrvPe+4/pIBD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bM9Rb+ubYCKX5R50BE2ssktep7AG25ONGD2WAHhV3nxDySK9m2JK69QqFaMX3vLnbqtIs2a8EONlRAKjUDgTSL2vFAgqgZxB0cv28oh75nZgucgpIyUPCVEQmjsa+djJe/+BiEdKy2s8qiXPEF4FXDEWqtFUcg1DBVnXdI196XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b0FGlJmo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b0FGlJmo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C0671F00ADB
	for <linux-can@vger.kernel.org>; Fri, 24 Jul 2026 09:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784884096;
	bh=p3A/4pifL2L3HVg1ufHCi9uHYCA1/oVSrgNwE9h/on0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=b0FGlJmoxLUWAbL5EySvN/iorG54cNgcEbPcOopN1zxTkSOQM7iS6Y5GebEXE8tuo
	 i2AAT0nyMYutEohZDbHYiKqj4scpCbnNH5ZnmuNrIhqM6TDmkoLTrX9iUFTs6rNkTL
	 xBuEyHohtFe2axC1uWt92aaOSyR3AyHHhpHTEg0IC9LFLCpJ8UmXEfJfc8aGwhWAgW
	 4KJ46Hu1Zv0NxhQmAvFVll4yba08ty8pd5oOCt6shiXDJoquZqSpSYdqVZdc6YupjC
	 jmZieSrU7Hc8Ix23o4jdBahuSrzTNbd67pIjXOJXCvX1/eQsz2odlVCAKKrQNPCRtR
	 m8Srnh0BEz9PQ==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6984169c126so335770a12.1
        for <linux-can@vger.kernel.org>; Fri, 24 Jul 2026 02:08:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rr1veHPqcQSLoRvcOz+UNXna0mFyzxGovxaQ76eLRuVWFH2zpQDlgiAG4x408eXCfm22AQ9HV4dwDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGGLpFqpFkCAe0IdUPZiuvFo0JJwhEicqPlKe5y8ucA9ArW5zx
	u+exvQa3aKV8wYeM0BfE1ywKNcQD8lefTdaPduJH/PY/FUeeO7PQ2ufdlCKZmmlcXqS6QuXTzqR
	bNjFAiTSEhwHG16NTi3UNzd09K8hx24M=
X-Received: by 2002:a05:6402:13cd:b0:69e:9b48:f3db with SMTP id
 4fb4d7f45d1cf-69f6c70e467mr2950108a12.29.1784884094973; Fri, 24 Jul 2026
 02:08:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1784597141.git.zhoubinbin@loongson.cn>
In-Reply-To: <cover.1784597141.git.zhoubinbin@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 24 Jul 2026 17:08:40 +0800
X-Gmail-Original-Message-ID: <CAAhV-H65TkXw-Vbh_uJ3=EwObzrvMohzVEJR2hi+4Z-3RQ==+Q@mail.gmail.com>
X-Gm-Features: AUfX_mwyj_QkLtDGP2oQlcn51XkEJOg4fpVQhWZEemOZS0A9nc_n_x6jlaC2KvQ
Message-ID: <CAAhV-H65TkXw-Vbh_uJ3=EwObzrvMohzVEJR2hi+4Z-3RQ==+Q@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] Add Loongson CAN-FD controller driver
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, Huacai Chen <chenhuacai@loongson.cn>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Bingxiong Li <libingxiong@loongson.cn>, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	linux-can@vger.kernel.org, jeffbai@aosc.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For the whole series:

Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>

On Tue, Jul 21, 2026 at 7:44=E2=80=AFPM Binbin Zhou <zhoubinbin@loongson.cn=
> wrote:
>
> Hi all:
>
> This patchset adds support for the CAN-FD controller found on Loongson
> CPUs.
>
> Patch 1 introduces the basic CAN-FD controller driver with support
> for classic CAN and CAN FD, including bit timing, error handling,
> NAPI-based RX, and multiple TX buffers.
>
> Patch 2 adds optional DMA support for RX path using the Loongson APB
> CMC DMA engine, which significantly reduces CPU load under high
> receive throughput.
>
> The driver has been tested on Loongson-2K3000 platforms with various
> CAN/CAN FD traffic patterns.
>
> Finally, I'd like to thank Bingxiong, the original author of this driver,
> for his efforts in working on the patch.
>
> Thanks.
> Binbin
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> V6:
> - Rebase on linux-can/master;
> Patch (1/2):
>  - Drop CAN_CTRLMODE_3_SAMPLES ctrlmode;
>  - Replace kfree_skb() with dev_kfree_skb_any();
>  - Drop REG_CMD_ERCRST operation;
>  - Rewrite `loongson_canfd_tx_interrupt()` to prevent duplicate handling
>    of TX completion';
> Patch (2/2):
>  - Added a fallback to true when dmaengine_tx_status() returns an error;
>  - Replaced all direct regmap_read() from LOONGSON_CANFD_RX_DATA with
>    the priv->get_rx_data() callback;
>  - Release the DMA channel and clear priv->rx_ch on dma_alloc_coherent()
>    failure;
>
> Link to V5:
> https://lore.kernel.org/all/cover.1783670733.git.zhoubinbin@loongson.cn/
>
> V5:
> Patch (1/2):
>  - Fix tseg1_max const value;
>  - Empty FIFO when SKB allocate failed.
>  - Use REG_FRAME_META1_RWCNT as the playload read count value;
>  - Only clean processed interrupt flags in
>    loongson_canfd_err_interrupt();
>  - Refact loongson_canfd_tx_interrupt();
>  - Add LOONGSON_CANFD_TRV_DLY into loongson_canfd_volatile_reg();
> Patch (2/2):
>  - Fix dma_request_chan() error path;
>  - Fix build error;
>  - Fix loongson_canfd_rxdma_init() error path;
>
> Link to V4:
> https://lore.kernel.org/all/cover.1783391759.git.zhoubinbin@loongson.cn/
>
> V4:
> - Fix some issues from sashiko.
> Patch (1/2):
>  - Update commit message;
>  - Use common APIs to calculate DLC;
>  - Correct CAN_RTR_FLAG judgement;
>  - Add skb check for CAN_STATE_ERROR_ACTIVE case;
>  - Use regmap_write() rather than regmap_update_bits() to
>    disable all interrupts;
>  - Add napi_disable() in error paths;
>  - Add `clock-frequency` return value check;
>  - More comments for macros.
>
> Link to V3:
> https://lore.kernel.org/all/cover.1782787997.git.zhoubinbin@loongson.cn/
>
> V3:
> Patch (1/2):
>  - Replace the switch-case statement with a calculated mask in
>    `loongson_canfd_get_txbuf_sts()`;
>  - Change `loongson_canfd_reset()` return type to `void`;
>  - Drop old code in `loongson_canfd_set_btr()`;
>  - Rename `loongson_canfd_set_mode()` to `loongson_canfd_set_conf_mode()`=
;
>  - Drop `cf->__res*` usage;
>  - Drop unnecessary macro definitions;
>  - Add `netif_napi_del()` in probe error route path;
>  - Replace ternary operator with `if-else`;
>  - Drop stats->rx_packets and stats->rx_bytes count in CAN error frames;
>  - Add ethtool_ops;
>  - Add CAN_CTRLMODE_CC_LEN8_DLC;
>
> Patch (2/2):
>  - Fix W=3D2 warning;
>  - Rename get_rx_frc() -> get_rxbuf_empty();
>  - Put `loongson_canfd_rxdma_remove()` before free_candev();
>  - Adjust the RXDMA probe process.
>
> Link to V2:
> https://lore.kernel.org/all/cover.1780908445.git.zhoubinbin@loongson.cn/
>
> V2:
> Patch (1/2):
>  - Put all code into one file;
>  - Add COMPILE_TEST Kconfig option;
>  - Rewrite Kconfig description;
>  - Use `regmap_test_bits()` to simplify bit field checks;
>  - Drop odd FIELD_GET() usage;
>  - Don't use FIELD_GET() for a single bit;
>  - Use an if/else instead of the ternary operator;
>  - Use the CAN TDC framework to get the SSP value;
>  - Use guard(spinlock)/scoped_guard(spinlock);
>  - Use netdev_debug() to be less verboss;
>  - Check for memory allocation failure;
>  - Add CAN_ERR_CNT flag;
>  - Drop unused REG_DATA_xx_yy_W_DATA_yy definition;
>  - Add more function comment;
>
> Link to V1:
> https://lore.kernel.org/all/cover.1777273055.git.zhoubinbin@loongson.cn/
>
> Binbin Zhou (2):
>   can: Add Loongson CAN-FD controller driver
>   can: loongson_canfd: Add RXDMA support
>
>  MAINTAINERS                      |    7 +
>  drivers/net/can/Kconfig          |   11 +
>  drivers/net/can/Makefile         |    1 +
>  drivers/net/can/loongson_canfd.c | 1877 ++++++++++++++++++++++++++++++
>  4 files changed, 1896 insertions(+)
>  create mode 100644 drivers/net/can/loongson_canfd.c
>
>
> base-commit: 1cb8553c02e93e5a150cebd42f9ee3db0ece4707
> --
> 2.52.0
>
