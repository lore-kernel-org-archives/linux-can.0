Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9881E4457B8;
	Thu,  1 Oct 2026 19:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790884109; cv=none; b=LpMmK3U821gaAP30qXowbChOMHiAfD7sfaJPDNW0/GeMyE0l3Li6KdKa4s7Y7vsvBxxlZlMxPQuDjcfmYPcE2wejJey7DEsD/kzNgicj5Mzlcu85Yu3v+0KK71g8BtP2C9tXioOUqrJMKqKPl6oxDsnz27n7IUXe5jzxULM+/L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790884109; c=relaxed/simple;
	bh=QsLMyWUPraaQcNfoYrzO6iBuz7FBiFJzaiSQaYG/BGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pGzXJbPTP9CfN2nPhblGtLl1Bkbw0U3+kw4MPpRPMh8NmDa5g4uroMwBGEgCdHXrMDPXa+ukwf4hi3RH4DCsJMmATVlrrmdr0R7I9rI9he842ahn86Ne/Xc3iYRh5HosnZvk4bdc2t4KkD/zk7mBy8gKv26qEIIz1K6uA7r1PiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TyrtKDvK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TyrtKDvK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011F51F00893;
	Thu,  1 Oct 2026 19:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790884108;
	bh=7hVXV+bP94VOVdRN13tGpaWUN5pK6ZTa2bHB9j5sq5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TyrtKDvKr7ybGmgTBiEiqQRdE44bJaZCAwDSaT90g525Y82W8OxKBHoXwXoJxrnRg
	 cdVM1YLzMPfjIqhCK31qf9BZBUnT/dE1AGtdEFzOdRQwx+sXElvPf7mAFptT39dYiq
	 zmMByAOb/WNsSThEZsEXfrJ4YzrBVmPwYPQ4TpoP0OHf6ArhhETV9kUOfyRjueGqi1
	 n/jDnlIqi7OdAKxfkgbQyXbbjvMZguAQYXcGtbvoBF5mukoDcrdOEzbQTOLah4zFWX
	 WzMoqOoW8Qdahd08JhzVLmkjA5+Fv+SBCvHxt4Zl5HkY8XCpoTp6UzpiVHzJW1lCVZ
	 cn1WnZ09reLMQ==
Date: Thu, 1 Oct 2026 14:48:26 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Quchaosheng <quchaosheng000406@163.com>
Cc: Vincent Mailhol <mailhol@kernel.org>, linux-kernel@vger.kernel.org,
	Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>, devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: net: can: convert grcan to DT schema
Message-ID: <179088367401.1689772.5473897250547043702.robh@kernel.org>
References: <20260929073703.2748220-1-quchaosheng000406@163.com>
 <20260929073703.2748220-2-quchaosheng000406@163.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929073703.2748220-2-quchaosheng000406@163.com>


On Tue, 29 Sep 2026 15:37:02 +0800, Quchaosheng wrote:
> grcan.txt is the only CAN controller binding whose device does not have a
> compatible string.  There are no device tree source files for LEON SPARC,
> and the nodes are built by the PROM from the AMBA plug&play information,
> which carries a core name and a register window but no compatible.  The
> driver matches on the node name instead.
> 
> It is the last of the five CAN controller bindings that were still written
> as free-form text; the other four are posted separately.
> 
> A binding without a compatible string is not selected by dtbs_check,
> because nodes are matched through their compatible values.  The schema
> therefore needs an explicit select on the node name.  This is the same
> mechanism ethernet-phy.yaml uses for optional-compatible nodes, and
> without it the schema would never be applied to anything.
> 
> Two further details are worth pointing out, because the text binding got
> them wrong or left them implicit:
> 
>   - "systemid" is not a property of the controller node.  The driver and
>     arch/sparc/kernel/leon_kernel.c both read it from the "/ambapp0" node,
>     so it is described in the description rather than in properties.  The
>     binding is stricter than the text file here, and dtbs_check now
>     rejects a controller node that carries it.
> 
>   - The node name format is "<core name>@<irq>,<address>", as built by
>     ambapp_path_component() in arch/sparc/kernel/prom_32.c from the "name"
>     and "reg" properties of the AMBA plug&play core.  The select pattern
>     and the example follow that format.
> 
> The "name" property of the text binding is not described: dtc enforces
> that it equals the base node name and then deletes it from the output, so
> it never reaches a compiled devicetree.
> 
> This binding does not reference can-controller.yaml, unlike the other CAN
> controller schemas.  That common schema constrains the node name to
> "^can(@.*)?$", which these nodes cannot satisfy -- they are named after
> the AMBA plug&play core.  Referencing it makes every valid node fail.
> 
> No functional change.  The driver comment is updated by a separate patch.
> 
> Assisted-by: LLM
> Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
> 
> ---
>  .../bindings/net/can/aeroflexgaisler,grcan.yaml    | 65 ++++++++++++++++++++++
>  .../devicetree/bindings/net/can/grcan.txt          | 28 ----------
>  2 files changed, 65 insertions(+), 28 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

However, is this a platform you actually care about? Sparc is not 
something anyone runs dtschema validation on, so not all that important 
to worry about. Only someone with access to a system can actually run 
the validation anyways.

The priority is fixing the remaining warnings on arm64 (about 200 left), 
arm32, mips, powerpc, arc in that order of priority. I don't know that 
anyone cares about mips, powerpc, or arc warnings either.

Rob
