import type { MetadataRoute } from "next";

// Keep bots off the API/app; crawlers were burning Vercel's free request quota.
export default function robots(): MetadataRoute.Robots {
  return {
    rules: [{ userAgent: "*", allow: "/", disallow: ["/api/", "/dashboard", "/automations", "/logs", "/r/", "/invite", "/verify-request"] }],
  };
}
