Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C29444161D;
	Wed, 15 Jul 2026 10:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784111241; cv=none; b=aIKtIesnWS9I8jl3It3pzgKD9wUGoxC/kuo19SWxROFXD7mODJ/C+khICxQulOV4EKMNEfTC45EgsNLeZ/3bMWHuQwfi1Fp22Lh73QWDHs8xfHKl4z92f8QSNk4PDe/8fs9k9OMsXsIVeMZ3HRfnd89PDW9wlLgVznWpNHVp2FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784111241; c=relaxed/simple;
	bh=8v/sPeABjxTXNekECO25wOGBkYc+zW5ozZehkdkpILc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fuPBZwv3dd9DS/zXFbjDEN2NpmCtEJXmJKo/HzGFzih9pDvZsTnLaKWeeWCXCXnsngkXI/G+svTF0+HUkiOSDavYOkK6tcLZEmwe9A4/EUBSb4b2vytEz/ethh+mizgdLkxBA9outihVX84091OPjCj7mnZWxFm+iSABYjRd1XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FED31F00A3A;
	Wed, 15 Jul 2026 10:27:14 +0000 (UTC)
Message-ID: <0ac841f8-ec96-4bd9-9c0f-8e19a977aa01@tuxon.dev>
Date: Wed, 15 Jul 2026 13:27:13 +0300
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] clk: r9a08g045-cpg: Add clocks and resets for
 CAN-FD
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: mkl@pengutronix.de, mailhol@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, geert+renesas@glider.be,
 magnus.damm@gmail.com, mturquette@baylibre.com, sboyd@kernel.org,
 bmasney@redhat.com, biju.das.jz@bp.renesas.com,
 fabrizio.castro.jz@renesas.com, claudiu.beznea@tuxon.dev,
 linux-can@vger.kernel.org, devicetree@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20260714173315.1981708-1-claudiu.beznea+renesas@tuxon.dev>
 <20260714173315.1981708-2-claudiu.beznea+renesas@tuxon.dev>
 <CAMuHMdUgvwjb7zNnsRXX9AzaUVAhVmks4yU5P+pJ0in6NyA+ww@mail.gmail.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>
In-Reply-To: <CAMuHMdUgvwjb7zNnsRXX9AzaUVAhVmks4yU5P+pJ0in6NyA+ww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Geert,

On 7/15/26 11:58, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Tue, 14 Jul 2026 at 19:33, Claudiu Beznea
> <claudiu.beznea+renesas@tuxon.dev> wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Renesas RZ/G3S SoC has a CAN-FD IP. Add clocks and resets for it.
>>
>> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
>>
>> Changes in v3:
>> - none
> 
> No need to resend applied patches.

Apologies for any inconvenience. I worked against next-20260713. I missed to 
check the yesterday next.

Thank you,
Claudiu
