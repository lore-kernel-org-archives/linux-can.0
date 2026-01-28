Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4273F26FD9A;
	Wed, 28 Jan 2026 01:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769564979; cv=none; b=C1aaVt/tANIQjI0WRykcFm7JwU6MPTieFS3qEylmBOcY7AU6cdD9Y9Ian1ngwnIPR3BFtMk4mQnzKn1ciOOFD/aSrdviU4bqlonbfJ3n6b1AC6H1/r+S3PgbxViqAIFPyY2OU0Y1Dngo8wGHwkOdhQtXiN1opV4dB7M5QzIkwJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769564979; c=relaxed/simple;
	bh=LmlDh7XQoR/5SAMFNmjfJ2NmKm7XssYMM/ojJHBto7w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S4mF4Q/N/XwNjDCNq7DyPl41Oz3pvHChzBJlERNf8eAwBBi71CNVvhzd1hsKCSAW5wbnYTyCTOE9KTTLl7FLlPn9hMzvaCktNDtamCqUGjDIX6rfXDv6ieeUJxQy9KGapzyrVr1Aq/F+yJU9Kb01/WQCgwdJ0gzxrm78e6LZ+9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QE78IlUe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QE78IlUe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99CAEC116C6;
	Wed, 28 Jan 2026 01:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769564978;
	bh=LmlDh7XQoR/5SAMFNmjfJ2NmKm7XssYMM/ojJHBto7w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QE78IlUezka3cEnkGMt1j4SJXwPLczNz0n9069SDBbSqidlvXHOwH6qq6LvWwUDXB
	 RYchsfuIFT+dQYoNyWLQuvE0uoQIJovHzjCzXPAg0+Hr8N9fjDfmjlBm+Ft8dQAQ1u
	 /0IeGpOxPiybAJTS1rRPbjsmQ5A3VZ+XSnyfe8FsMeZULtu/whaMLHXXCoYQNlhQ5q
	 V8S5DI0tYo2tG8uoNDEbuWV+jueFVS0b3v1yUEShSltZ5gk/5h+eleZzSq/h4DR4to
	 n45UJ8PXr6BJXU/hiLxz3td/V1Br0n2lXNxEWPh/HyhWJVLxqaG9itkdrvIDjBZ8IJ
	 WjikPMUn5YSSQ==
Date: Tue, 27 Jan 2026 17:49:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org
Subject: Re: [net-next 0/6] move CAN skb headroom content to skb extensions
Message-ID: <20260127174937.4c5fc226@kernel.org>
In-Reply-To: <20260125201601.5018-1-socketcan@hartkopp.net>
References: <20260125201601.5018-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 25 Jan 2026 21:15:55 +0100 Oliver Hartkopp wrote:
> CAN bus related skbuffs (ETH_P_CAN/ETH_P_CANFD/ETH_P_CANXL) simply contain
> CAN frame structs for CAN CC/FD/XL of skb->len length at skb->data.
> Those CAN skbs do not have network/mac/transport headers nor other such
> references for encapsulated protocols like ethernet/IP protocols.
> 
> To store data for CAN specific use-cases all CAN bus related skbuffs are
> created with a 16 byte private skb headroom (struct can_skb_priv).
> Using the skb headroom and accessing skb->head for this private data
> led to several problems in the past likely due to "The struct can_skb_priv
> business is highly unconventional for the networking stack." [1]
> 
> This patch set aims to remove the unconventional skb headroom usage for
> CAN bus related skbuffs and use the common skb extensions instead.

This is fine. Wish we could make md_dst work, since skb_ext still burns
a bit in the skb (last extension bit in fact, next user will have to
bump the filed size). And you very much do not route these frames, 
so dst would work perfectly fine. But whatever.

lore never received patch 6, tho, you'll need to repost.
-- 
pw-bot: cr
