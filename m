Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897E737268F;
	Tue, 21 Jul 2026 13:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784641974; cv=none; b=mFvYEmAPZ2/9sE2O826hhAmbi2XvkouIlCnPPEIPFmwXba+D7d1B07IN0jwdCmW9007nf/Vjzl5xEhnyGaVkz1/yVNb3x8GRipPJNG7GHTHv7S9pQY+LhpA+sN3w8/8b25JGf+KQTGxmPLfoyACo069ySH37Y5ZYyuVJGZoHouU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784641974; c=relaxed/simple;
	bh=drm3VEvQGHvC1OZn74Ss5dz5GesRAHvtNzpj87gOvtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PO9szOT5v24I8hNaBxvddVj7m1vytpQ6/4+gK/cXX2nRd6uPrSDgIhP3jcCXPP/DCmirvMLp/vj53aHyD7c7o+BWmJBM5+o3fuuSYYQbVMkU+O9wrCoqzSSqDiVisU4igA2dxjgpUz5ocIdZ7tLIorEo/tb9/0/DcWGrgNlJkHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PAWT5HY9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAWT5HY9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35FD41F00A3D;
	Tue, 21 Jul 2026 13:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784641973;
	bh=1QXqTwGKlbP68LBaMvREQDMp15H6OiXtEo69Ua3ayKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PAWT5HY9IK0Sy+w/qXg5G4P7P+xGLq2lGJKIYLBvJ9mJEtST2Iyz0tx0K6HjKdQxv
	 kompVwwPE8XWOiFObi62m51XGKrJcSCv3o3MGiKKyNcX6ckYvr6i8Ev/5dsQKUSI9N
	 nyYAZlkQ0KFfNLJ1dADM6Xhn1oLcFJw6I6708zFfce3v49C9ir3IG6AoZYfDoWY2b5
	 KbPo+RhWr2mTNReOBwlMjE9qVYcT0S8ob9OXDwcWbu6HR2mw3DnOrsxGxeWmDjjIxu
	 DEOOskIlV9SV2qePVWrjqQal9QvgXuorDMi8Tu9d+i12qILuzHw+p3sVCo61GOy03P
	 2LJLgAWkicQZA==
Date: Tue, 21 Jul 2026 08:52:52 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Eduard Bostina <egbostina@gmail.com>
Cc: goledhruva@gmail.com, linux-kernel@vger.kernel.org,
	simona.toaca@nxp.com, daniel.baluta@nxp.com,
	devicetree@vger.kernel.org, Vincent Mailhol <mailhol@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>, m-chawdhry@ti.com,
	Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: net: can: Convert TI HECC to DT schema
Message-ID: <178464197211.3471129.12579860341723074902.robh@kernel.org>
References: <20260719140127.3558941-1-egbostina@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260719140127.3558941-1-egbostina@gmail.com>


On Sun, 19 Jul 2026 14:01:27 +0000, Eduard Bostina wrote:
> Convert the Texas Instruments High End CAN Controller (HECC) bindings
> to DT schema.
> 
> Signed-off-by: Eduard Bostina <egbostina@gmail.com>
> ---
>  .../bindings/net/can/ti,am3517-hecc.yaml      | 64 +++++++++++++++++++
>  .../devicetree/bindings/net/can/ti_hecc.txt   | 32 ----------
>  2 files changed, 64 insertions(+), 32 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/can/ti,am3517-hecc.yaml
>  delete mode 100644 Documentation/devicetree/bindings/net/can/ti_hecc.txt
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

