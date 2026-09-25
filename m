Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5524947B41C;
	Fri, 25 Sep 2026 08:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790325901; cv=none; b=e9sjBydPjgJRy5UAbPdJsdUNaC34ytJv9glTXpJ6WKU+E9fx3+ejnjN/IC1SXn+8TXsmv5n21SGM4Wg7Dm/I4OEaIMKyw0zoroUFB6m/DdqSsUBrTyy5m3liSLHWSvWOiWfBJyV21LA7FXZscGyeHiAVt7Wm0G2gnp7F3pftI9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790325901; c=relaxed/simple;
	bh=Xnpxzyl1VitSE1CuGQQGxwEm9MKUJAgntBbBZjzRJYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hEzhluoRONUfCv24Uk6hsjl1+Mx+lAgWAl/0zt6N42MpuBKExMzrZvGX5bKqDygzUm3rLny7dRJiocW4oVlbegq9kQ21pJrlSvyDVp/7VRjRyxUZykhqJdD+51jRfqsQ5Mxbo4HO2hSqbV4dvKKMWlt7fBuCClK5yWvEydwnOAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WuLs9Zux; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WuLs9Zux"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F6F1F000FF;
	Fri, 25 Sep 2026 08:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790325886;
	bh=+TBj6XNx6wj4tb6xMCEx/veq3j9/yAgIG5jriFy+zgw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=WuLs9ZuxqSxZLNvI0720+UO2PQwoEyf1mAC4X1hFUWMAPTL90Z7F1j2tQqbJI+YZa
	 LlANaNc8T3sE3DI4izxYwG+984t2KhDhwlvqAxh1OA72qG+WcPl5uQMC6C4wdSxzuw
	 5/+RclUKafRTrxls5Hr7bgRpigC7Uqu5NojBWvovamRYK8rRbTkNiTgr7JCoZcoFZI
	 66xLh7k4uMQDEPUD+cvEkb7YLt1DHxDYJdNUy5tPIC0XSVRibsWOuKzFrmIgsO0PeI
	 mifo6LRDz4RWgyXi7EWgwbEE0KHBcDwz3KkI3BMpG7/wq+R6NUZWqBuf7hdyxIaFiM
	 5fldM+40eNVfg==
Message-ID: <35b1f45f-28e2-4e36-89e8-64b016596a6b@kernel.org>
Date: Fri, 25 Sep 2026 11:44:42 +0300
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] can: rcar_canfd: Derive max_channels from the
 device tree
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
 <mailhol@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>
Cc: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Tu Nguyen <tu.nguyen.xg@renesas.com>, linux-can@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org,
 Chris Paterson <Chris.Paterson2@renesas.com>,
 Biju Das <biju.das@bp.renesas.com>
References: <20260925082134.146015-1-biju.das.jz@bp.renesas.com>
 <20260925082134.146015-3-biju.das.jz@bp.renesas.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@kernel.org>
In-Reply-To: <20260925082134.146015-3-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/25/26 11:21, Biju Das wrote:
> The maximum number of channels is currently hardcoded per SoC in
> struct rcar_canfd_hw_info. Since the DT describes the channels as
> child nodes of the controller, the count can be obtained at probe time
> with of_get_child_count() instead.
> 
> Drop max_channels from struct rcar_canfd_hw_info and store the value
> in struct rcar_canfd_global, so it no longer needs to be maintained
> for each SoC variant. Update all for_each_set_bit() users over
> channels_mask to use gpriv->max_channels.
> 
> No functional change.
> 
> Signed-off-by: Biju Das<biju.das.jz@bp.renesas.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
